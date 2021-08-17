import Darwin
import Foundation

func quit(_ description: String = "") {
    if !description.isEmpty || debug { describe(a, b) }
    print("ERROR".red)
    print(description.yellow)
    exit(0)
}

func fill() -> [Int] {
    var numbers: [Int] = []
    var arguments = Array(CommandLine.arguments.dropFirst())
    if arguments.count == 1 {
        arguments = arguments[0].components(separatedBy: " ")
    }
    numbers = arguments.map{Int($0)!}
    let desiredCount = numbers.count
    numbers = Array(Set(numbers))
    if Set(numbers).count != desiredCount {
        print("Error: repeating numbers".red)
        print("Generating new set......\n".green)
        var count = numbers.count
        while count < desiredCount {
            let n = Int(Int32.random(in: Int32.min...Int32.max))
            if !numbers.contains(n) {
                numbers.append(n); count += 1
            }
        }
    }
    return numbers
}

/*
** limit is used to force quit from cases like an infinite loop
** debug is set to print out description of stacks every operation
** muted is set to silence operation logging
** counter keeps track of operation count
*/

let limit = 40000
let debug = false
var muted = false
var counter = 0

let numbers = fill()
let count = numbers.count
let sortedNumbers = numbers.sorted()

var a = buildStack(from: numbers)
var b = buildStack(from: [])

func main() {
    switch count {
         case 1...3: sortThree(of: .a)
         case 4...5: sortFive(of: .a)
         case 6..<100: sortDivide(by: 2)
         case 100..<300: sortDivide(by: 4)
         case 300...500: sortDivide(by: 8)
         default: sortDivide(by: findBestDivision())
    }
    describe(a, b)
    print((a?.isSorted(by: .ascending) ?? false) ? "OK".green : "KO".red)
    print("instrunctions count: \(counter)".yellow)
}

main()
