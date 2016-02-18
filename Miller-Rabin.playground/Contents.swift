import Foundation

/// This algorithm impliments the Miller-Rabin primality test
///
/// - warning: This test is not deterministic
/// - warning: This test is rather slow for the size numbers in use
/// - parameter n (int): The numer being tested
/// - parameter k (int): The accuracy of the test
/// - returns: True if the number is probably prime or False if it is composite
func isProbablyPrime(n: Int, k: Int) -> Bool {
    
    // The Special Cases
    if(n==1) { return false }
    if(n==2 || n==3) { return true }
    // Perform Trial Divisions
    if(n%2==0) { return false }
    if(n%3==0) { return false }
    
    var d = n-1
    var s = 0
    
    while(d % 2 == 0) {
        d/=2
        s++
    }
    
    for(var i = 0; i < k; i++) {
        let a = Int(drand48() * Double(n-2)) + 2
        var x = powMod(a, power: d, mod: n)
        if(x == 1 || x == n-1) {
            continue
        }
        var shouldDoubleBreak = false
        for(var j=0; j < s; j++) {
            x = (x*x)%n
            if(x == 1) {
                return false
            }
            if(x == n-1) {
                shouldDoubleBreak = true
                break
            }
        }
        
        if(shouldDoubleBreak && x != n-1) {
            return false
        }
        
    }
    return true
}


/// This algorithm impliments modular exponentiation
///
/// - parameter base (int): The base of the modular exponentiation problem
/// - parameter power (int): The power of the modular exponentiation
/// - parameter mod (int): The mod of the modular exponentiation
/// - returns: The result of (base^power) modulo (mod)
func powMod(base: Int, power: Int, mod: Int) -> Int {
    var result = 1
    for(var i=0;i<power;i++) {
        result = (result * base) % mod;
    }
    return result
}


isProbablyPrime(73, k: 100)


