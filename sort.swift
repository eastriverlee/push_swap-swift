import Foundation

func reset() {
    A = nil
    B = nil
    A = buildStack(from: numbers)
    counter = 0
}

func findBestDivision(from skip: Int = 0) -> Int {
    var performance: [Int] = []

    muted = true
    for i in 1...10 {
        if skip < i {
            reset()
            sortDivide(by: i)
            print("instrunctions count: \(counter)".yellow)
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
    return best
}

func push(_ number: Int, from this: Option) -> Int {
    let that = this.counter
    var stack: Stack { this.stack! }
    let isCloserFromTop = number.isCloserFromTop(of: stack)

    while number != stack.number {
        isCloserFromTop ? r(this) : rr(this)
    }
    p(that)
    return number
}

func push(_ i: Int, and j: Int, from this: Option) {
    let that = this.counter
    var stack: Stack { this.stack! }
    var other: Stack? { that.stack }
    let iIsCloser = stack.distance(to: i) < stack.distance(to: j)

    _ = push(iIsCloser ? i : j, from: this)
    _ = push(iIsCloser ? j : i, from: this)
    if let other = other, !other.isSorted(to: 1, by: that.order) { s(that) }
}

func push(_ i: Int, or j: Int, from this: Option) -> Int {
    var stack: Stack { this.stack! }
    let iIsCloser = stack.distance(to: i) < stack.distance(to: j)

    return push(iIsCloser ? i : j, from: this)
}

func sortThree(of this: Option) {
    var stack: Stack { this.stack! }
    let array = stack[0..<min(3, stack.count)]
    let extreme = this == .a ? array.max()! : array.min()!

    if let second = stack.down, second.number == extreme {
        rr(this)
    }
    if stack.number == extreme { 
        r(this)
    }
    if !stack.isSorted(to: 2, by: this.order) {
        s(this)
    }
}

func sortFive(of this: Option) {
    let that = this.counter
    var stack: Stack { this.stack! }
    let array = stack[0..<min(5, stack.count)]
    let sortedFive = array.sorted()
    let first = sortedFive[this == .a ? 0 : array.count-1]
    let second = sortedFive[this == .a ? 1 : array.count-2]

    if array.count > 3 { push(first, and: second, from: this) }
    sortThree(of: this)
    p(that)
    p(that)
}

func sort(only count: Int, from index: inout Int, end: Bool = false) {
    var smallest = index-(count-1)
    let next = smallest-1
    let small = sortedNumbers[smallest]
    let big = sortedNumbers[index]
    var bCount = 0
    var rotated = 0

    while bCount < count {
        if small <= A!.number && A!.number <= big {
            p(.b); bCount += 1
        } else { r(.a) }
    }
    while bCount > 5 { 
        let pushed = push(sortedNumbers[index], or: sortedNumbers[smallest], from: .b); bCount -= 1
        if pushed == sortedNumbers[index] {
            index -= 1
        } else {
            smallest += 1
            r(.a); rotated += 1
        }
    }
    index = next
    sortFive(of: .b)
    while B != nil { p(.a) }
    for _ in 0..<rotated { rr(.a) }
    if !end { for _ in rotated..<count { r(.a) } }
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
