//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }

    let positions = lines[0].components(separatedBy: ",").map { Int($0)! }

    let min = positions.min()!
    let max = positions.max()!

    var fuels = [Int]()
    for i in min ... max {
        fuels.append(calcFuel(crabs: positions, anchor: i))
    }

    print(fuels.min()!)
}

func calcFuel(crabs: [Int], anchor: Int) -> Int {
    crabs.reduce(0) { partialResult, crab in
        partialResult + abs(crab - anchor)
    }
}

func main2() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }

    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }

    let positions = lines[0].components(separatedBy: ",").map { Int($0)! }

    let min = positions.min()!
    let max = positions.max()!

    var fuels = [Int]()
    for i in min ... max {
        fuels.append(calcFuel2(crabs: positions, anchor: i))
    }

    print(fuels.min()!)
}

func main3() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }

    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }

    let positions = lines[0].components(separatedBy: ",").map { Int($0)! }

    let min = positions.min()!
    let max = positions.max()!

    let result = search(start: min, end: max, positions: positions)

    print(result)
}

func search(start: Int, end: Int, positions: [Int]) -> Int {
    let mid = (start + end) / 2
    let fuelMin = calcFuel2(crabs: positions, anchor: start)
    let fuelMax = calcFuel2(crabs: positions, anchor: end)

    if mid == end || mid == start {
        return min(fuelMin, fuelMax)
    }

    if fuelMin < fuelMax {
        return search(start: start, end: mid, positions: positions)
    } else {
        return search(start: mid, end: end, positions: positions)
    }
}

func calcFuel2(crabs: [Int], anchor: Int) -> Int {
    crabs.reduce(0) { partialResult, crab in
        let distance = abs(crab - anchor)
        var fuel = 0
        for i in 0 ... distance {
            fuel += i
        }
        return partialResult + fuel
    }
}

//main()
//main2()
main3() // binary search to solve #2
