import React, { Component } from 'react';
import SearchBar from './SearchBar';
import ContactList from './ContactList';

class Contacts extends Component {
  render() {
    return (
      <div>
        <SearchBar />
        <ContactList contacts={this.props.contacts} />
      </div>
    )
  }
}

export default Contacts;