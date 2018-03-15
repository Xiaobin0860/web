import { createStore, applyMiddleware } from 'redux';
import trunk from 'redux-thunk';
import reducers from '../reducers';

const middleWare = [trunk];
const createStoreWithMiddleware = applyMiddleware(...middleWare)(createStore);
const store = createStoreWithMiddleware(reducers);
export default store;