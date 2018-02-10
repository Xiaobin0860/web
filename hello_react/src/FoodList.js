import React, { Component } from 'react';

class FoodList extends Component {
  render() {
    return (
      <ul>
        <Item1 quantity="1" name="Bread" />
        <Item1 quantity="2" name="Eggs" />
        <Item2 quantity="3">Milk</Item2>
      </ul>
    );
  }
}

class Item1 extends Component {
  render() {
    return (
      <li>
        {this.props.quantity}*{this.props.name}
      </li>
    );
  }
}

class Item2 extends Component {
  render() {
    return (
      <li>
        {this.props.quantity}*{this.props.children}
      </li>
    );
  }
}

export default FoodList;