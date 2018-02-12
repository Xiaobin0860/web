import React, { Component } from 'react';
import Contacts from './Contacts';
import 'whatwg-fetch'

class ContactsContainer extends Component {
    constructor() {
        super();
        this.state = {
            contacts: []
        }
    }

    componentDidMount() {
        fetch('./contacts.json')
            .then((response) => response.json())
            .then((data) => {
                this.setState({ contacts: data });
            })
            .catch((e) => console.log('Error fetching or parsing data!', e));
    }

    render() {
        return <Contacts contacts={this.state.contacts} />;
    }
}

export default ContactsContainer;