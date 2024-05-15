import { useState } from "react"
import Light from './Light.jsx'
import './TrafficLight.css'

function TrafficLight() {
    const [state, setState] = useState('red')

    function nextStep() {
        if (state === 'red') {
            setState('green')
        } else if (state === 'yellow') {
            setState('red')
        } else {
            setState('yellow')
        }
    }

    return (
        <div className="trafficLight" onClick={nextStep}>
            <Light color={'red'} active={state === 'red'}></Light>
            <Light color={'yellow'} active={state === 'yellow'}></Light>
            <Light color={'green'} active={state === 'green'}></Light>
        </div>
    )
}

export default TrafficLight