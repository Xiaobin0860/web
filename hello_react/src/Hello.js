import React, { Component } from 'react';
import Clock from './Clock';

class Hello extends Component {
  render() {
    return (
      <div className='Hello'>
        <h1>Hello, {this.props.name}!</h1>
        <Clock />
      </div>
    );
  }
}

export default Hello;