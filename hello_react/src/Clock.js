import React, { Component } from 'react';

class Clock extends Component {
  constructor(props) {
    super(props);
    this.state = {
      date: new Date(),
      isToggleOn: true
    };
  }

  componentDidMount() {
    this.timerID = setInterval(
      () => this.tick(),
      1000
    );
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  tick() {
    this.setState({
      date: new Date()
    });
  }

  handleClick() {
    if (this.state.isToggleOn) {
      clearInterval(this.timerID);
    }
    else {
      this.timerID = setInterval(
        () => this.tick(),
        1000
      );
    }
    this.setState({ isToggleOn: !this.state.isToggleOn });
  }

  render() {
    return (
      <div>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
        <button onClick={(e) => this.handleClick(e)}>
          {this.state.isToggleOn ? 'ON' : 'OFF'}
        </button>
      </div>
    );
  }
}

export default Clock;