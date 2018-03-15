import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import registerServiceWorker from './registerServiceWorker';
import { Provider } from 'react-redux';
import store from './store';
import App from './containers/App';

ReactDOM.render(<App />, document.getElementById('root'));
registerServiceWorker();
