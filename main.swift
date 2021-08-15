import Darwin

func quit() {
    print("Error")
    exit(0)
}

func fill() -> [Int] {
    var arguments = CommandLine.arguments
    arguments = Array(arguments[1 ..< arguments.count])
    if arguments.count == 1 {
        arguments = arguments[0].components(separatedBy: " ")
    }
    return arguments.map{Int($0)!}
}

let numbers = fill()
if Set(numbers).count != numbers.count { quit() }
var a = buildStack(from: numbers)
var b = buildStack(from: [])

func sort() {
    
}

//example
let debug = true
describe(a, b)
rr(.a)
rr(.a)
p(.b)
r(.a)
p(.b)
r(.both)
s(.a)
s(.b)
s(.both)
p(.a)
p(.a)
