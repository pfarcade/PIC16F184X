using System;
using System.IO.Ports;

class Program
{
    static SerialPort serialPort;

    static void Main(string[] args)
    {
        serialPort = new SerialPort();

        serialPort.PortName = "COM4";
        serialPort.BaudRate = 9600; 

        serialPort.DataReceived += SerialPortDataReceived;

        try
        {
            // Open the serial port
            serialPort.Open();
            Console.WriteLine("Serial port opened.");

            serialPort.WriteLine("Test, WLAN!");

            Console.ReadKey();
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
        finally
        {
            // Close the port
            if (serialPort.IsOpen)
                serialPort.Close();

            Console.WriteLine("Serial port closed.");
        }
    }

    static void SerialPortDataReceived(object sender, SerialDataReceivedEventArgs e)
    {
        // Read the incoming data
        string data = serialPort.ReadExisting();

        // Print
        Console.WriteLine("Received data: " + data);
    }
}
