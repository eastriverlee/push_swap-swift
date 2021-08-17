import Darwin

func quit(_ description: String = "") {
    if !description.isEmpty || debug { describe(a, b) }
    print("ERROR".red)
    print(description.yellow)
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
    if Set(numbers).count != count {
        print("Error: repeating numbers".red)
        print("Generating new set......\n".green)
        let desiredCount = count
        numbers = Array(Set(numbers))
        var count = count
        while count < desiredCount {
            let n = Int(Int32.random(in: Int32.min...Int32.max))
            if !numbers.contains(n) {
                numbers.append(n)
                count += 1
            }
        }
    }
    return numbers
}

func push(_ number: Int, from this: Option) {
    var stack: Stack { this == .a ? a! : b! }
    let other: Option = (this == .a ? .b : .a)

    if number.isCloserFromTop(of: stack) {
        while number != stack.number {
            r(this)
        }
    } else {
        while number != stack.number {
            rr(this)
        }
    }
    p(other)
}

func push(two numbers: [Int], from this: Option) {
    let other: Option = (this == .a ? .b : .a)
    var stack: Stack { this == .a ? a! : b! }
    var otherStack: Stack? { this == .a ? b : a }
    let fromTop = numbers.areCloserFromTop(of: stack)
    var leftover: Int!

    func pushOne() {
        p(other)
        if !(otherStack?.isSorted(to: 1, by: other == .b ? .descending : .ascending) ?? true) {
            s(other)
        }
    }
    func get(_ i: Int, or j: Int) {
        while i != stack.number && j != stack.number {
            fromTop ? r(this) : rr(this)
        }
        leftover = stack.number == i ? j : i
    }
    get(numbers[0], or: numbers[1])
    pushOne()
    push(leftover, from: this)
}

extension Sequence where Iterator.Element == Int {
    func areCloserFromTop(of stack: Stack) -> Bool {
        let count = stack.count
        let middle = count / 2
        let distance: [Int] = self.map { stack.find($0) }
        return distance.reduce(0, +)/distance.count < middle
    }
}

func sortThree(of this: Option, by order: Order? = nil) {
    var stack: Stack { this == .a ? a! : b! }
    let array = stack[0..<min(3, stack.count)]
    let extreme = this == .a ? array.max()! : array.min()!
    if let second = stack.down, second.number == extreme {
        rr(this)
    }
    if stack.number == extreme { 
        r(this)
    }
    if !stack.isSorted(to: 2, by: this == .a ? .ascending : .descending) {
        s(this)
    }
}

func sort(only count: Int = count, from index: inout Int, end: Bool = false) {
    let smallest = sortedNumbers[index - (count-1)]
    let biggest = sortedNumbers[index]
    var bCount = 0

    while bCount < count {
        if smallest <= a!.number && a!.number <= biggest {
            p(.b)
            bCount += 1
        } else { r(.a) }
    }
    while bCount-- > 0 { 
        push(sortedNumbers[index--], from: .b)
    }
    if !end { for _ in 0..<count { r(.a) } }
}

func sortDivide(by parts: Int) {
    var index = count-1
    let part = count/parts
    let leftover = part + count%parts
    for _ in 0..<parts-1 {
        sort(only: part, from: &index)
    }
    sort(only: leftover, from: &index, end: true)
}

func reset() {
    b = nil
    a = buildStack(from: numbers)
    counter = 0
}

func findBestDivision() {
    var performance: [Int] = []
    let skip = 1

    muted = true
    for i in 1...15 {
        if skip < i {
            reset()
            sortDivide(by: i)
            performance.append(counter)
        }
    }
    let min = performance.min()!
    let best = skip+performance.firstIndex{ $0 == min }!+1
    print("performance: \(performance)")
    print("best performance: \(min)")
    print("best division: \(best)")
    reset()
    muted = false
    sortDivide(by: best)
}


//MARK: - main

let limit = 1000
let debug = false
var muted = false
let numbers = fill()
let count = numbers.count
let sortedNumbers = numbers.sorted()

var a = buildStack(from: numbers)
var b = buildStack(from: [])

func main() {
    //findBestDivision()
    guard let _ = a else { exit(0) }

    //describe(a, b)
    switch count {
         case 0: break
         case 1...3: sortThree(of: .a)
         case 4..<100: sortDivide(by: 2)
         case 100..<500: sortDivide(by: 4)
         default: sortDivide(by: 8)
    }
    //describe(a, b)
    print((a?.isSorted(by: .ascending) ?? false) ? "OK".green : "KO".red)
    print("instrunctions count: \(counter)".yellow)
}

main()
