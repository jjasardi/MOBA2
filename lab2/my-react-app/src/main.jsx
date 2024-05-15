import React from 'react'
import ReactDOM from 'react-dom/client'
import TrafficLight from './TrafficLight'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <div style={{display: 'flex'}}>
      <TrafficLight></TrafficLight>
      <TrafficLight></TrafficLight>
    </div>
  </React.StrictMode>,
)
