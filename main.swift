import Darwin

func quit() {
    print("Error")
    if debug { describe(a, b) }
    exit(0)
}

func fill() -> [Int] {
    var numbers: [Int] = []
    var arguments = CommandLine.arguments
    arguments = Array(arguments[1 ..< arguments.count])
    if arguments.count == 1 {
        arguments = arguments[0].components(separatedBy: " ")
    }
    numbers = arguments.map{Int($0)!}
    if Set(numbers).count != numbers.count {
        print("Error: repeating numbers".red)
        print("Generating new set......\n".green)
        let desiredCount = numbers.count
        numbers = Array(Set(numbers))
        var count = numbers.count
        while count < desiredCount {
            let n = Int(Int32.random(in: Int32.min ... Int32.max))
            if !numbers.contains(n) {
                numbers.append(n)
                count += 1
            }
        }
    }
    return numbers
}

func get(_ number: Int, from option: Option) {
    var stack: Stack { option == .a ? a! : b! }

    if number.isCloserFromTop(of: stack) {
        while number != stack.number {
            r(option)
        }
    } else {
        while number != stack.number {
            rr(option)
        }
    }
}

func sort() {
    let count = numbers.count
    for i in 0 ..< count {
        get(sortedNumbers[i], from: .a)
        p(.b)
    }
    for _ in 0 ..< count {
        p(.a)
    }
}

let debug = false
let numbers = fill()
let sortedNumbers = numbers.sorted()
var a = buildStack(from: numbers)
var b = buildStack(from: [])

func main() {
    if let a = a, !a.isSorted(by: .ascending) {
        sort()
    }
    describe(a, b)
}

main()
