import UIKit

//MARK: Ejercicio: Invertir una lista enlazada
/*Descripción:

Tienes una lista enlazada simple. Cada nodo de la lista contiene un valor y un puntero al siguiente nodo. El objetivo es invertir el orden de los nodos de la lista, es decir, el último nodo debe convertirse en el primero, el penúltimo en el segundo, y así sucesivamente.

Ejemplo:

Lista original: 1 -> 2 -> 3 -> 4 -> 5
Lista invertida: 5 -> 4 -> 3 -> 2 -> 1
*/
/*
NO RESUELTO
class Node {
    var value: Int
    var next: Node?
    
    init(_ value: Int) {
        self.value = value
    }
}

var nodo1 = Node(10)
var nodo2 = Node(20)
var nodo3 = Node(30)
var nodo4 = Node(40)
var nodo5 = Node(50)
var nodo6 = Node(60)
nodo1.next = nodo2
nodo2.next = nodo3
nodo3.next = nodo4
nodo4.next = nodo5
nodo5.next = nodo6


func imprimirLista(nodo: Node) {
    if nodo.next != nil {
        print("|\(nodo.value)|\(nodo.next?.value)| ->")
        imprimirLista(nodo: nodo.next!)
    } else {
        print("|\(nodo.value)|\(nodo.next?.value)|")
    }
    return
}

func reverseList(nodo nodoInicial: Node) {
    if nodoInicial.next == nil {
        return
    }
    var nodoGuia = 2
    var nodoAux = nodoInicial.next!
    while nodoInicial.next != nil {
        
    }
}


func reversoLista(nodo nodoSuperior: Node) -> (Node, Node) {
    imprimirLista(nodo: nodoSuperior)
    if nodoSuperior.next != nil {
        var inferior = reversoLista(nodo: nodoSuperior.next!)
        print("Nodo Inferior: |\(inferior.value)|\(inferior.next?.value)|")
        print("Nodo Superior: |\(nodoSuperior.value)|\(nodoSuperior.next?.value)|")
        inferior.next = nodoSuperior
        nodoSuperior.next = nil
    }
    print("Después del if:")
    var nuevoPrimero = nodoSuperior
    imprimirLista(nodo: nodoSuperior)
    return (nuevoPrimero, nodoSuperior)
}

//imprimirLista(nodo: nodo1)
let nuevoInicial = reversoLista(nodo: nodo1)
print("\n\n\n\n\n-----------Final del orde-----------")
imprimirLista(nodo: nuevoInicial)
 
 
 
 func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
     // Implementación aquí
 }
*/

// MARK: Ejercicio 1: Dos Sum
///Problema: Dado un array de enteros, encuentra dos números que sumen un valor objetivo dado. Debes devolver los índices de estos dos números.
///let nums = [2, 7, 11, 15]
///let target = 9
/// Resultado esperado: [0, 1]

/// x + y = n
/// x = n - y
/// y = n - x
/// x + y - n = 0
///
/// 9-2 = 7
///  [2, 7, 11, 4, -2, 15, 5]
///  [11, 7, 2, -2, 5, -6, 4]
///  [5, 2, 4, -2, 7, 11]
/*
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    for num in nums {
        var numeroABuscar = target - num
        var complemento = nums.first(where: { $0 == numeroABuscar })
        if let valor = complemento {
            print("pares: ", [nums.firstIndex(of: num)!, nums.firstIndex(of: valor)!])
            return [nums.firstIndex(of: num)!, nums.firstIndex(of: valor)!]
        }
    }
    return []
}

twoSum([2, 11, 4, -2, 15, 5, 7], 9)
*/



// MARK: Ejercicio 2: Longest Substring Without Repeating Characters
/// Problema: Dada una cadena, encuentra la longitud de la subcadena más larga sin caracteres repetidos.
/// let s = "abcabcbb"
/// Resultado esperado: 3 (La subcadena más larga sin caracteres repetidos es "abc")
///
/*
func lengthOfLongestSubstring(_ s: String) -> Int {
    var arreglo = s.split(separator: "").map { String($0) }
    var tamanio = 0
    var indice = 0
    var cadena = [arreglo[indice]]
    for index in 1..<arreglo.count {
        if cadena.contains(arreglo[index]) {
            tamanio = tamanio < cadena.count ? cadena.count : tamanio
            indice += 1
            cadena = [arreglo[indice]]
        }
        cadena.append(arreglo[index])
    }
    return tamanio
}
let s = "abcabcbb"
lengthOfLongestSubstring(s)
*/

// MARK: Ejercicio 1: Reordenar una Matriz para que Siga una Secuencia
//Problema: Dada una matriz de enteros nums, reorganízala de tal manera que cada elemento sea mayor que su predecesor y menor que su sucesor, es decir, cumpla una secuencia como un "pico" o "valle". Por ejemplo, dado un array [1, 2, 3, 4, 5], reorganiza los elementos para que el resultado sea algo como [2, 1, 4, 3, 5]. En este caso, 2 > 1 < 4 > 3 < 5.
//
//Requisitos:
//    La solución debe tener una complejidad temporal de O(n log n) o mejor.

/// Par
///  [1, 5, 1, 1, 6, 4]
///  [1, 1, 1, 4,  5, 6] -> sort
///  [1, 1, 1]
///  [4, 5, 6]
///
///  Impar
///  [1, 5, 1, 1, 6, 4, 3]
///  [1, 1, 1, 3, 4,  5, 6] -> sort
///  [1, 1, 1, 3]
///  [4, 5, 6]
/*
func rearrangeArray(_ nums: inout [Int]) {
    nums.sort()
    let midpoint = nums.count / 2
    let isImpar = nums.count % 2 != 0
    
    var firstHalf = nums[..<midpoint]
    var secondHalf = nums[midpoint...].sorted(by: >)
    var merged = zip(firstHalf, secondHalf).flatMap { [$1, $0] }
    if isImpar {
        merged.append(firstHalf.last!)
    }
    nums = merged
}

var serie = [1, 5, 1, 1, 6, 4]
rearrangeArray(&serie)
print(serie)
*/



// MARK: Ejercicio 2: Anagramas en un Array
//Problema: Dado un array de cadenas, agrupa las cadenas que son anagramas entre sí. Un anagrama es una palabra o frase que se forma reorganizando las letras de una palabra o frase diferente, típicamente utilizando todas las letras originales exactamente una vez.
//
//Requisitos:
//
//La solución debe ser eficiente, preferiblemente con una complejidad temporal de O(n * m log m), donde n es el número de cadenas y m es la longitud promedio de las cadenas.
//Debes implementar la solución en Swift.

//EJEMPLO:
//let strs = ["eat", "tea", "tan", "ate", "nat", "bat"]
//let result = groupAnagrams(strs)
//print(result)
// Ejemplo de salida: [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
/*
func groupAnagrams(_ strs: [String]) -> [[String]] {
    var anagramsDict = [String: [String]]()

    for word in strs {
        let sortedWord = String(word.sorted())
        
        if anagramsDict[sortedWord] != nil {
            anagramsDict[sortedWord]!.append(word)
        } else {
            anagramsDict[sortedWord] = [word]
        }
    }

    let result = Array(anagramsDict.values)
    print(result)
    return result
}

groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"])
*/


//MARK: Ejercicio 3: Subarray con Suma Máxima
//Problema: Dado un array de enteros, encuentra el subarray contiguo con la suma máxima. Un subarray es una secuencia continua de elementos dentro del array original. La suma máxima es el valor máximo de la suma de todos los elementos en cualquier subarray contiguo.
//
//Requisitos:
//
//Debes implementar la solución en Swift.
//La solución debe tener una complejidad temporal de O(n).
//
//let nums = [-2, 1, -3, 4, -1, 2, 2, -5, 4]
//let result = maxSubArraySum(nums)
//print(result) // Ejemplo de salida: 6 (subarray: [4, -1, 2, 1])

/// [2,     -3,      2,       2,      0]
/// [     -1,     ...   ... ... .          ]
/// [             1,           ... ...    ]

//var arreglo = [2, -3, 2, 2, 0]
//var arreglo = [-1, 5, 3, 2, -3, 7]

func maxSubArraySum(_ nums: [Int]) -> [Int] {
    var maximo_total = arreglo[0]
    var maximo_actual = arreglo[0]
    var conjunto: [Int] = Array()

    for i in 1..<arreglo.count {
        maximo_actual = max(arreglo[i], maximo_actual + arreglo[i])
        if maximo_actual + arreglo[i] > arreglo[i] {
            conjunto.append(arreglo[i])
        }
        if maximo_actual > maximo_total {
            maximo_total = maximo_actual
        }
    }
    print(maximo_total, conjunto.reduce(0, +))
    print(conjunto)
    return conjunto
}
var arreglo = [-2, 1, -3, 4, -6, 2, 2, -5, 4]
maxSubArraySum(arreglo)

