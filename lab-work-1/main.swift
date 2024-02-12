import Foundation

func add(_ a: Double, _ b: Double) -> Double {
    return a + b
}

func subtract(_ a: Double, _ b: Double) -> Double {
    return a - b
}

func multiply(_ a: Double, _ b: Double) -> Double {
    return a * b
}

func divide(_ a: Double, _ b: Double) throws -> Double {
    guard b != 0 else {
        throw CalculationError.divideByZero
    }
    return a / b
}

func power(_ a: Double, _ b: Double) -> Double {
    return pow(a, b)
}

enum CalculationError: Error {
    case invalidInput
    case divideByZero
}

func getUserInput() -> (Double, Double, String)? {
    print("Enter first number:")
    guard let num1 = Double(readLine() ?? "") else {
        print("Invalid input. Please enter a valid number.")
        return nil
    }
    
    print("Enter second number:")
    guard let num2 = Double(readLine() ?? "") else {
        print("Invalid input. Please enter a valid number.")
        return nil
    }
    
    print("Enter operation (+, -, *, /, ^):")
    guard let operation = readLine(), ["+", "-", "*", "/", "^"].contains(operation) else {
        print("Invalid operation. Please enter a valid operator.")
        return nil
    }
    
    return (num1, num2, operation)
}

func performCalculation() {
    guard let (num1, num2, operation) = getUserInput() else {
        return
    }
    
    do {
        var result: Double
        switch operation {
        case "+":
            result = add(num1, num2)
        case "-":
            result = subtract(num1, num2)
        case "*":
            result = multiply(num1, num2)
        case "/":
            result = try divide(num1, num2)
        case "^":
            result = power(num1, num2)
        default:
            throw CalculationError.invalidInput
        }
        print("Result: \(result)")
    } catch CalculationError.divideByZero {
        print("Error: Cannot divide by zero.")
    } catch {
        print("An unknown error occurred.")
    }
}

func main() {
    while true {
        performCalculation()
        print("Do you want to perform another calculation? (yes/no)")
        if let response = readLine(), response.lowercased() != "yes" {
            break
        }
    }
}

main()
