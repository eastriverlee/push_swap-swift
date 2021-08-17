import Foundation

enum Order {
    case ascending
    case descending
}

class Stack {
    init(_ n: Int, on stack: Stack? = nil, below: Stack? = nil) {
        number = n
        down = stack
        up = below
    }
    var number: Int
    var down: Stack?
    var up: Stack?
    var copy: Stack { Stack(number, on: down, below: up) }
    var bottom: Stack { self[count - 1] }
    var count: Int { 
        var stack: Stack? = self
        var count = 0
        while (stack != nil) {
            stack = stack?.down
            count += 1
        }
        return count
    }

    subscript(i: Int) -> Stack {
        var stack = self
        if i > 0 {
            for _ in 0..<i {
                stack = stack.down!
            }
        }
        return stack
    }

    subscript(range: Range<Int>) -> [Int] {
        var stack: Stack? = self[range.lowerBound]
        var array: [Int] = []
        for _ in range {
            array.append(stack!.number)
            stack = stack?.down
        }
        return array
    }

    func swap() {
        if let down = down {
            let temp = number
            number = down.number
            down.number = temp
        }
    }

    func find(_ n: Int) -> Int {
        var current: Stack? = self
        for i in 0..<count {
            if current == nil { break }
            if n == current!.number { return i }
            current = current!.down
        }
        return -1
    }

    func isSorted(from start: Int = 0, to end_: Int = -1, by order: Order) -> Bool {
        let end = end_ == -1 ? count - 1 : end_
        var current: Stack? = self
        var isSorted = true
        func hasError() -> Bool {
            isSorted = 
            (order == .descending && current!.number > current!.down!.number) ||
            (order == .ascending && current!.number < current!.down!.number)
            return !isSorted
        }
        for _ in 0 ..< start { current = current!.down }
        for _ in start ..< end {
            if current?.down == nil || hasError() { break }
            current = current?.down
        }
        return isSorted
    }
}

func push(_ n: Int, on stack: inout Stack?) {
    let temp = Stack(n, on: stack)
    stack?.up = temp
    stack = temp
}

func push(_ this: inout Stack?, on stack: inout Stack?) {
    if let n = pop(&this) { push(n, on: &stack) }
}

func pop(_ stack: inout Stack?) -> Int? {
    let n = stack?.number
    stack = stack?.down
    stack?.up = nil
    return n
}

func rotate(_ stack: inout Stack?) {
    if let bottom = stack?.bottom, let secondTop = stack?.down {
        secondTop.up = nil
        bottom.down = Stack(stack!.number, below: bottom)
        stack = secondTop
    }
}

func rrotate(_ stack: inout Stack?) {
    if let bottom = stack?.bottom, let secondBottom = bottom.up {
        push(bottom.number, on: &stack)
        secondBottom.down = nil
    }
}

func buildStack(from numbers: [Int]) -> Stack? {
    var stack: Stack? = nil
    for number in numbers.reversed() {
        push(number, on: &stack)
    }
    return stack
}

func describe(_ a: Stack?, _ b: Stack?, color: ANSI = .cyan) {
    let counts = [a?.count ?? 0, b?.count ?? 0]
    let count = max(counts[0], counts[1])
    var stacks = [a, b]
    print(color.rawValue)
    for i in (0..<count).reversed() {
        var number: [String] = [" ", " "]
        for j in 0 ..< 2 {
            if let stack = stacks[j], counts[j] > i {
                number[j] = "\(stack.number)"
                stacks[j] = stack.down
            }
        }
        print(number[0] + "\t\t" + number[1])
    }
    print("_\t\t_")
    print("a\t\tb\n")
    print(ANSI.none.rawValue)
}
