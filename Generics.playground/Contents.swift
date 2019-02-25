//: Genéricos

/*:
 Genéricos: plantillas de código que se completan en tiempo de compilación
 
 - Funciones genéricas
 - Clases genéricas
 - Structs & Enums genéricos
 - Protocolos genéricos: se implementan de otra forma a los demás y son 2º Dan
 
 ## Funciones genéricas
 */

func swapInt(a: inout Int, b: inout Int) {
    let aux = a
    a = b
    b = aux
}

var a = 3
var b = 2
(a, b)
swap(&a, &b)
(a, b)

// Versión genérica de swap
func swapAny<A>(a: inout A, b: inout A) {
    let aux = a
    a = b
    b = aux
}

swapAny(a: &a, b: &b)
(a, b)

var s1 = "Hola"
var s2 = "Mundo"

swapAny(a: &s1, b: &s2)
(s1, s2)


/*:
 Estructuras de datos genéricas: Class, Struct, Enum
 
 */

struct Pair<First, Second> {
    let first: First
    let second: Second
}

let p = Pair(first: 4, second: ["Hola", "Mundo"])
p.first
p.second

// Poner restricciones a los tipos genéricos
struct HashPair<Value, Key: Hashable> {
    let value: Value
    let key: Key
}

struct Foo {}

// let h = HashPair(value: "Has", key: Foo()) //ERROR xq Foo no impleneta Hashable

// Para más de una restricción es mejor usar la sintaxis del where. Ver libro

// Mezcla de genérico y específico
struct MixedPair<T> {
    let head: Int
    let tail: T
}

/*
 ## Protocólos genéricos
 
 En vez de una variable de tipo genérica, se usa un "tipo asociado"
 
 Es 2º Dan. No hay que meterse con esto, de momento
 
 No creeis o extendáis protocols genéricos hasta llegar a cinturón negro 
 */

protocol Bar {
    associatedtype Element
}
