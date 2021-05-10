// 4 вариант
`define Fclk        48000000 // 50000000    //50 MHz
`define BR          9600      //BAUDRATE - скорость 9.6 kBOD
`define Nt          `Fclk/`BR // 16'h1458 // 5208 //`Fclk/`BR   //50000000/9600
`define MY_ADR      16'h4900     //Базовый адрес
`define XCRC16      16'h4002     //CRC (x^16 + x^15 + x^2 + 1)
`define INIT_CRC    16'hFFFF   //Инициализация регистра CRC
