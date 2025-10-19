# Electromechanical Bike Modeling

## Project Overview

This project implements comprehensive modeling and simulation of an electromechanical bike system with DC motor propulsion using MATLAB/Simulink. The project focuses on the electrical and mechanical dynamics of an electric bike drive system, developed as part of the Practice Modelling and Simulation (PMS) module for the Master Engineering Systems program at Han University of Applied Sciences.

## Author Information

- **Name**: Tomo Emmanuel Adegboyega
- **Student Number**: 2103826  
- **Institution**: Han University of Applied Sciences
- **Program**: Master Engineering Systems
- **Date**: April 3rd, 2023

## Project Description

The project focuses on developing and validating mathematical models for an electromechanical bike drive system powered by a DC motor. The modeling incorporates both electrical motor dynamics and mechanical bike dynamics including transmission, wheel radius, and road load effects. Three different modeling approaches are implemented:
- **Differential Equations**: Direct mathematical modeling of the complete electromechanical system
- **Transfer Function**: Frequency domain representation of motor-bike dynamics
- **State Space**: Modern control theory approach for integrated system analysis

## System Parameters

### Electrical Parameters
- Armature resistance (R): 0.03 Ω
- Armature inductance (L): 2.5 mH
- Back-emf constant (Kb): 0.35 V·s/rad

### Mechanical Parameters
- Moment of inertia (J): 0.005 kg·m²
- Motor torque constant (Kt): 0.9 Nm/A
- Bearing friction coefficient (B): 0.24 Nm·s/rad
- Transmission ratio (i): 0.2
- Dynamic wheel radius (r): 0.3 m

### Bike and Road Load Parameters
- Rolling resistance (W): 45 kg·m/s²
- Bike + rider mass (Y): 300 kg
- Total weight (Z): 3000 N
- Aerodynamic coefficient (X): 0.46 kg/m

## Project Structure

```
├── PMS.m                    # Main MATLAB script
├── EM1.slx                  # Primary Simulink model
├── EMB1.slx                 # Model for B parameter sensitivity analysis
├── EMI1.slx                 # Model for transmission ratio sensitivity analysis  
├── EMJ1.slx                 # Model for inertia sensitivity analysis
├── InputOutputData.xlsx     # Experimental validation data
├── PMS_Tomo_EA_2103826.pdf  # Project documentation
├── slprj/                   # Simulink project files
└── README.md               # This file
```

## Features

### 1. Mathematical Modeling
- **Transfer Function**: $P_{motor} = \frac{K_t}{s[(J·s + B)(L·s + R) + K_b·K_t]}$
- **State Space Representation**: 
  - State vector: [position, angular velocity, current]
  - 3×3 system matrix with electrical and mechanical dynamics

### 2. Bike Operation Scenarios
- **Scenario 1**: Low speed cycling (1 m/s), acceleration phase (0.4s)
- **Scenario 2**: Normal cycling speed (2 m/s), steady operation (3.0s) 
- **Scenario 3**: High speed cycling (3 m/s), extended ride (5.0s)

### 3. Model Validation
- Comparison with experimental data from `InputOutputData.xlsx`
- Validation of both angular speed and current responses
- Statistical analysis of model accuracy

### 4. Sensitivity Analysis
- **Inertia (J)**: Analysis of moment of inertia variations
- **Damping (B)**: Bearing friction coefficient sensitivity
- **Transmission Ratio (i)**: Gear ratio impact assessment

## Getting Started

### Prerequisites
- MATLAB R2022a or later
- Simulink
- Control System Toolbox (recommended)

### Running the Project

1. **Clone or download the project files**
2. **Open MATLAB and navigate to the project directory**
3. **Run the main script**:
   ```matlab
   run('PMS.m')
   ```
4. **The script will automatically**:
   - Initialize system parameters
   - Run all simulation scenarios
   - Generate comparison plots
   - Perform model validation
   - Execute sensitivity analysis

### Individual Model Execution

To run specific Simulink models:
```matlab
% Run primary model
sim('EM1.slx')

% Run sensitivity analysis models
sim('EMB1.slx')  % B parameter analysis
sim('EMI1.slx')  # Transmission ratio analysis
sim('EMJ1.slx')  % Inertia analysis
```

## Results and Analysis

The project generates multiple visualization outputs:

1. **Transfer Function Response**: Comparison of input voltage and angular speed
2. **State Space Response**: State space model validation
3. **Model Comparison**: Side-by-side comparison of all three modeling approaches
4. **Scenario Analysis**: Behavior under different operating conditions
5. **Validation Plots**: Simulated vs. measured data comparison
6. **Sensitivity Analysis**: Parameter variation impact on system performance

## Model Equations

### Transfer Function
The motor transfer function relates input voltage to angular velocity:

$$H(s) = \frac{\omega(s)}{V(s)} = \frac{K_t}{s[(J·s + B)(L·s + R) + K_b·K_t]}$$

### State Space Model
```
ẋ = Ax + Bu
y = Cx + Du

Where:
A = [0    1    0  ]
    [0   -B/J  Kt/J]
    [0   -Kb/L -R/L]

B = [0; 0; 1/L]
C = [0 1 0]  
D = [0]
```

## Validation Results

The model validation compares simulated results against experimental data, showing:
- Angular speed correlation
- Current response accuracy
- System behavior under various operating conditions

## Contributing

This is an academic project. For questions or suggestions, please contact the author.

## License

This project is developed for educational purposes as part of academic coursework at Han University of Applied Sciences.

## Acknowledgments

- Han University of Applied Sciences
- Master Engineering Systems Program
- Practice Modelling and Simulation Course Module

---

**Note**: This project demonstrates the application of control theory and system modeling techniques to electromechanical bike systems, providing valuable insights into electric bike drive dynamics, motor-transmission integration, and validation methodologies for sustainable transportation solutions.