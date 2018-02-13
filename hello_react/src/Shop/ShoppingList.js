import React, { Component } from 'react';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group';

class AnimatedShoppingList extends Component {
  constructor() {
    super();
    this.state = {
      items: [
        { id: 1, name: 'Milk' },
        { id: 2, name: 'Yogurt' },
        { id: 3, name: 'Orange Juice' }
      ]
    }
  }

  handleChange(e) {
    if (e.key === 'Enter') {
      let newItem = { id: Date.now(), name: e.target.value };
      let newItems = this.state.items.concat(newItem);
      e.target.value = '';
      this.setState({ items: newItems });
    }
  }

  handleRemove(i) {
    let newItems = this.state.items;
    newItems.splice(i, 1);
    this.setState({ items: newItems });
  }

  render() {
    let shoppingItems = this.state.items.map((item, i) => (
      <div key={item.id} className="item" onClick={this.handleRemove.bind(this, i)}>
        {item.name}
      </div>
    ));
    return (
      <div>
        <ReactCSSTransitionGroup transitionName="example"
          transitionEnterTimeout={300}
          transitionLeaveTimeout={300}
          transitionAppear={true}
          transitionAppearTimeout={300}>
          {shoppingItems}
        </ReactCSSTransitionGroup>
        <input className="shop_input" type="text" value={this.state.newItem} onKeyDown={(e) => this.handleChange(e)} />
      </div>
    )
  }
}

export default AnimatedShoppingList;