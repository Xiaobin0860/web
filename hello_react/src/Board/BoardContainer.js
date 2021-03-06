import React, { Component } from 'react';
import Board from './Board';
import update from 'react-addons-update'
import 'whatwg-fetch'
import 'babel-polyfill'

class BoardContainer extends Component {
  constructor() {
    super();
    this.state = {
      cards: []
    };
  }

  componentDidMount() {
    fetch('./cards.json')
      .then((res) => res.json())
      .then((d) => this.setState({ cards: d }))
      .catch((e) => console.log('Error fetching or parsing data', e));
  }

  addTask(cardId, taskName) {
    let cardIndex = this.state.cards.findIndex((card) => card.id === cardId);
    let newTask = { id: Date.now(), name: taskName, done: false };
    console.log(newTask);
    let nextState = update(this.state.cards, {
      [cardIndex]: {
        tasks: { $push: [newTask] }
      }
    });
    this.setState({ cards: nextState });
  }
  deleteTask(cardId, taskId, taskIndex) {
    let cardIndex = this.state.cards.findIndex((card) => card.id === cardId);
    let nextState = update(this.state.cards, {
      [cardIndex]: {
        tasks: { $splice: [[taskIndex, 1]] }
      }
    });
    this.setState({ cards: nextState });
  }
  toggleTask(cardId, taskId, taskIndex) {
    let cardIndex = this.state.cards.findIndex((card) => card.id === cardId);
    let newDoneValue;
    let nextState = update(this.state.cards, {
      [cardIndex]: {
        tasks: {
          [taskIndex]: {
            done: {
              $apply: (done) => {
                newDoneValue = !done;
                return newDoneValue;
              }
            }
          }
        }
      }
    });
    this.setState({ cards: nextState });
  }

  render() {
    return <Board cards={this.state.cards}
      taskCallbacks={{
        toggle: this.toggleTask.bind(this),
        delete: this.deleteTask.bind(this),
        add: this.addTask.bind(this)
      }} />;
  }
}

export default BoardContainer;