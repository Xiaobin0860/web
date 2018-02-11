import React, { Component } from 'react';
import PropTypes from 'prop-types';
import FocusText from './FocusText';

class CheckList extends Component {
  render() {
    let tasks = this.props.tasks.map((task) => (
      <li className="checklist__task" key={task.id}>
        <input type="checkbox" defaultChecked={task.done} />
        {task.name}
        {/* <a href="#" className="checklist__task--remove" /> */}
      </li>
    ));
    return (
      <div className="checklist">
        <ul>{tasks}</ul>
        <input type="text" className="checklist--add-task" placeholder="Type then hit Enter to add a task" />
        <FocusText />
      </div>
    );
  }
}

CheckList.propTypes = {
  tasks: PropTypes.arrayOf(PropTypes.object)
}

export default CheckList;