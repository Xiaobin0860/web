import React, { Component } from 'react';
import PropTypes from 'prop-types';
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

Hello.propTypes = {
  name: PropTypes.string
}

export default Hello;