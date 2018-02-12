import React, { Component } from 'react';
import PropTypes from 'prop-types';

class SearchBar extends Component {
  handleChange(e) {
    this.props.onUserInput(e.target.value)
  }

  render() {
    return <input type="search"
      placeholder="search"
      value={this.props.filterText}
      onChange={(e) => this.handleChange(e)} />
  }
}

SearchBar.propTypes = {
  onUserInput: PropTypes.func.isRequired,
  filterText: PropTypes.string.isRequired
}

export default SearchBar;