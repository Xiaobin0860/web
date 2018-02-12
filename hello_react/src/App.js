import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Hello from './Hello'
import FoodList from './FoodList'
import BoardContainer from './Board/BoardContainer'
import ContactsContainer from './Contacts/ContactsContainer'

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
        </header>
        <Hello name="React" />
        <FoodList />
        <BoardContainer />
        <ContactsContainer />
      </div>
    );
  }
}

export default App;
