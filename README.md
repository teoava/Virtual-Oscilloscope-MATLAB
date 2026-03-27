# Virtual Oscilloscope - MATLAB GUI

A professional signal visualization tool developed in MATLAB that allows users to generate and manipulate electrical signals in real-time.

## 🚀 Features
- **Waveform Selection:** Toggle between Sinusoidal, Square, and Triangular waves.
- **Dynamic Controls:** Real-time adjustment for Frequency (1-25 Hz) and Amplitude (0.1-10 V).
- **Signal Analysis:** Option to inject Gaussian Noise to simulate real-world interference.
- **Interactive UI:** Status indicators and safety controls for starting/stopping the signal feed.

## 🛠️ Technical Details
- **Architecture:** Built using a callback-based system for UI responsiveness.
- **Timing:** Implemented a `timer` object with a 0.2s refresh rate to balance performance and visual smoothness.
- **Precision:** Uses specific mathematical models for wave generation and error handling for graph scaling.
- 
## 🎓 Academic Context
This project was developed at **ETTI - Universitatea Transilvania din Brașov** to demonstrate signal processing concepts and GUI development in MATLAB.
