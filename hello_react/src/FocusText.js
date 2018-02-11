import React, { Component } from 'react';

class FocusText extends Component {
  handleClick() {
    this.refs.myTextInput.focus();
  }
  render() {
    return (
      <div>
        <input type="text" ref="myTextInput" />
        <input type="button" value="Focus the text input" onClick={() => this.handleClick()} />
      </div>
    );
  }
}

export default FocusText;