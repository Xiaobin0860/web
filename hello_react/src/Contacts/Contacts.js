import React, { Component } from 'react';
import SearchBar from './SearchBar';
import ContactList from './ContactList';
import 'whatwg-fetch'

class Contacts extends Component {
  constructor() {
    super();
    this.state = {
      filterText: ''
    };
  }

  handleInput(term) {
    this.setState({ filterText: term })
  }

  render() {
    return (
      <div>
        <SearchBar filterText={this.state.filterText} onUserInput={(term) => this.handleInput(term)} />
        <ContactList contacts={this.props.contacts} filterText={this.state.filterText} />
      </div>
    )
  }
}

export default Contacts;