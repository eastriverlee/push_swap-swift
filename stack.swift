import Foundation

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
    var bottom: Stack { self[size - 1] }
    var size: Int { 
        var stack: Stack? = self
        var length = 0
        while (stack != nil) {
            stack = stack?.down
            length += 1
        }
        return length
    }

    subscript(i: Int) -> Stack {
        var stack = self
        for _ in 0 ..< i {
            stack = stack.down!
        }
        return stack
    }

    func swap() {
        if let down = down {
            let temp = number
            number = down.number
            down.number = temp
        }
    }

    func describe(with other: Stack? = nil) {
        var stacks: [Stack?] = [self, other]
        let sizes = [self.size, other?.size ?? 0]
        let size = max(sizes[0], sizes[1])
        for i in (0 ..< size).reversed() {
            var number: [String] = [" ", " "]
            for j in 0 ..< 2 {
                if let stack = stacks[j], sizes[j] > i {
                    number[j] = "\(stack.number)"
                    stacks[j] = stack.down
                }
            }
            print(number[0] + "\t" + number[1])
        }
        print("")
        print("_\t_")
        print("a\tb")
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
        bottom.down = Stack(stack!.number)
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

func describe(_ a: Stack?, _ b: Stack?) {
    let sizes = [a?.size ?? 0, b?.size ?? 0]
    let size = max(sizes[0], sizes[1])
    var stacks = [a, b]
    for i in (0 ..< size).reversed() {
        var number: [String] = [" ", " "]
        for j in 0 ..< 2 {
            if let stack = stacks[j], sizes[j] > i {
                number[j] = "\(stack.number)"
                stacks[j] = stack.down
            }
        }
        print(number[0] + "\t" + number[1])
    }
    print("_\t_")
    print("a\tb\n")
}
