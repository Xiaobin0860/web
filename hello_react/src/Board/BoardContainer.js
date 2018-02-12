import React, { Component } from 'react';
import Board from './Board';
import 'whatwg-fetch'

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

    render() {
        return <Board cards={this.state.cards} />;
    }
}

export default BoardContainer;