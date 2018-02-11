import React, { Component } from 'react';
import PropTypes from 'prop-types';
import ContactItem from './ContactItem';

class ContactList extends Component {
  render() {
    return (
      <ul>
        {this.props.contacts.map(
          (contact) => <ContactItem key={contact.email}
            name={contact.name}
            email={contact.email} />
        )}
      </ul>
    )
  }
}

ContactList.propTypes = {
  contacts: PropTypes.arrayOf(PropTypes.object)
}

export default ContactList;