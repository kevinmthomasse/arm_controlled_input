![image](https://github.com/mytechnotalent/ARM_Controlled_Input/blob/master/ARM%20Controlled%20Input.png?raw=true)

# ARM Controlled Input
ARM controlled input example taking a max of 4 bytes from the terminal and checking for a successful combination of int values in a row.

## Installation
```bash
git clone https://github.com/mytechnotalent/arm_controlled_input.git
cd arm_controlled_input
```

## Running

```bash
as arm_controlled_input.s -o arm_controlled_input.o
ld arm_controlled_input.o -o arm_controlled_input
./arm_controlled_input
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
