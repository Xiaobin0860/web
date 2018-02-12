import React, { Component } from 'react';
import PropTypes from 'prop-types';
import FocusText from '../FocusText';

class CheckList extends Component {
  checkInputKeyPress(e) {
    if (e.key === 'Enter') {
      console.log('cardId=' + this.props.cardId + ', value=' + e.target.value);
      this.props.taskCallbacks.add(this.props.cardId, e.target.value);
      e.target.value = '';
    }
  }

  render() {
    let tasks = this.props.tasks.map((task, index) => (
      <li className="checklist__task" key={task.id}>
        <input type="checkbox" checked={task.done} onChange={
          this.props.taskCallbacks.toggle.bind(null, this.props.cardId, task.id, index)
        } />
        {task.name}{' '}
        <button type="button" onClick={
          this.props.taskCallbacks.delete.bind(null, this.props.cardId, task.id, index)
        }>del</button>
      </li>
    ));
    return (
      <div className="checklist">
        <ul>{tasks}</ul>
        <input type="text"
          className="checklist--add-task"
          placeholder="Type then hit Enter to add a task"
          onKeyPress={(e) => this.checkInputKeyPress(e)} />
        <FocusText />
      </div>
    );
  }
}

CheckList.propTypes = {
  cardId: PropTypes.number,
  tasks: PropTypes.arrayOf(PropTypes.object),
  taskCallbacks: PropTypes.object
}

export default CheckList;