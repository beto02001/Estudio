//: [Previous](@previous)

import Foundation


func performAsyncTask() {
    DispatchQueue.global(qos: .default).async {
        sleep(2)
        print("Task completed")
    }
}

//performAsyncTask()


//MARK: Prueba 2: Actualización de la Interfaz de Usuario desde una Cola en Segundo Plano
//Instrucciones:
//Crea una función llamada updateUILabel.
//Dentro de la función, usa GCD para enviar una tarea asíncrona a una cola global.
//Simula una tarea de segundo plano usando sleep(2) para un retraso de 2 segundos.
//Después del retraso, cambia el texto de un UILabel (por ejemplo, llamado statusLabel) en el hilo principal para que diga "Updated!".
//Usa DispatchQueue.main.async para asegurarte de que la actualización de la UI ocurra en el hilo principal.
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var statusLabel: UILabel!
    
    func updateUILabel() {
        taskBackground()
    }
    
    func taskBackground() {
        DispatchQueue.global(qos: .background).async {
            sleep(2) // Simula una tarea de largo tiempo
            print("Tarea segundo plano")
            
            // Actualización de la UI en el hilo principal
            DispatchQueue.main.async {
                self.statusLabel.text = "Updated!"
            }
        }
    }
}



//MARK: Prueba 3: Uso de DispatchGroup para Sincronizar Múltiples Tareas Asíncronas
/*
Objetivo:
Aprender a utilizar DispatchGroup para sincronizar varias tareas asíncronas y ejecutar una tarea adicional solo cuando todas las tareas hayan finalizado.

Instrucciones:

Crea una función llamada performGroupedTasks.
Dentro de la función, crea una instancia de DispatchGroup.
Envía tres tareas diferentes a una cola global utilizando DispatchQueue.global().async.
Cada tarea debe simular un tiempo de procesamiento usando sleep(2), sleep(3), y sleep(4) respectivamente.
Asegúrate de que cada tarea informe al DispatchGroup cuando comience y cuando termine.
Usa el DispatchGroup para esperar a que todas las tareas finalicen.
Una vez que todas las tareas hayan terminado, imprime "All tasks completed" en la consola.
*/

func performGroupedTasks() {
    var group = DispatchGroup()
    
    DispatchQueue.global().async(group: group) {
        group.enter()
        sleep(2)
        print("Tarea 1 terminada")
        group.leave()
    }
    
    DispatchQueue.global().async(group: group) {
        group.enter()
        sleep(3)
        print("Tarea 2 terminada")
        group.leave()
    }
    
    DispatchQueue.global().async(group: group) {
        group.enter()
        sleep(4)
        print("Tarea 3 terminada")
        group.leave()
    }
    
    group.notify(queue: .main) {
        print("Terminaron todas las tareas")
    }
}

//performGroupedTasks()



//MARK: Prueba 4: Implementación de un DispatchSemaphore para Controlar el Acceso a Recursos Compartidos
//Objetivo:
//En esta prueba, aprenderás a usar DispatchSemaphore para controlar el acceso concurrente a un recurso compartido, lo que es crucial para evitar condiciones de carrera (race conditions) en el desarrollo de aplicaciones.
//
//Instrucciones:
//
//Imagina que estás desarrollando una aplicación donde varias tareas necesitan acceder a un recurso compartido, por ejemplo, una variable que guarda un contador.
//Crea una función llamada incrementCounterSafely que permita a múltiples hilos incrementar un contador de manera segura.
//Para garantizar que solo un hilo pueda acceder al recurso compartido a la vez, utiliza un DispatchSemaphore.
//La función debe simular el acceso concurrente desde varios hilos, donde cada hilo intenta incrementar el contador.
//Al final, verifica que el valor del contador sea consistente y no muestre un valor incorrecto debido a condiciones de carrera.

var contador = 0
var semaforo = DispatchSemaphore(value: 1)
var group = DispatchGroup()

func incrementCounterSafely(cantidad: Int) {
    semaforo.wait()
    print(Thread.current)
    contador = contador + cantidad
    print("Terminó de sumar")
    semaforo.signal()
}

DispatchQueue.global().async(group: group) {
    group.enter()
    incrementCounterSafely(cantidad: 3)
    group.leave()
    
}

DispatchQueue.global().async(group: group) {
    group.enter()
    incrementCounterSafely(cantidad: 1)
    group.leave()
    
}

DispatchQueue.global().async(group: group) {
    group.enter()
    incrementCounterSafely(cantidad: 2)
    group.leave()
    
}

group.notify(queue: .main) {
    print(contador)
}



//MARK: Desafío 4: Descarga de Imágenes Concurrente con GCD
//Problema:
//Imagina que estás desarrollando una aplicación iOS que necesita descargar varias imágenes desde la web y mostrarlas en una colección (por ejemplo, en un UICollectionView). Para mejorar la experiencia del usuario, quieres asegurarte de que las imágenes se descarguen de manera concurrente y eficiente utilizando Grand Central Dispatch (GCD).
//
//Tu tarea es implementar una función que realice la descarga de múltiples imágenes de manera concurrente y las almacene en un array. Debes asegurarte de que:
//
//Las descargas se realicen de manera concurrente utilizando DispatchQueue.
//El array que almacena las imágenes esté protegido contra accesos concurrentes incorrectos (por ejemplo, utilizando un semáforo o un DispatchBarrier).
//Notifiques al usuario cuando todas las imágenes hayan sido descargadas, y actualices la interfaz en el hilo principal.
//Clase sobre Descarga Concurrente con GCD
//Descarga Concurrente con GCD:
//
//Cuando manejamos múltiples descargas de recursos (como imágenes) en una aplicación iOS, es importante hacerlo de manera concurrente para mejorar la eficiencia y la experiencia del usuario. GCD ofrece herramientas como DispatchQueue para ejecutar tareas concurrentemente.
//
//Global Dispatch Queues: Estas son colas predefinidas que ofrecen diferentes niveles de calidad de servicio (QoS). Son útiles para tareas concurrentes que no necesitan ejecutar en el hilo principal.
//
//DispatchGroup: Puedes usar un DispatchGroup para manejar la sincronización entre varias tareas concurrentes. Esto te permite saber cuándo todas las tareas han terminado.
//
//Semáforos y Barreras: Para proteger un recurso compartido (como un array), puedes usar un semáforo (DispatchSemaphore) o una barrera (DispatchBarrier). Esto asegura que el acceso al recurso sea seguro y que no se produzcan condiciones de carrera.
//
//Pasos para Resolver el Problema:
//
//Crear una cola concurrente: Utiliza una cola global o crea una nueva cola concurrente personalizada.
//
//Realizar las descargas concurrentemente: Usa async para iniciar las descargas de manera concurrente en la cola.
//
//Proteger el array de imágenes: Utiliza un semáforo o barrera para asegurar que el array se modifique de manera segura.
//
//Actualizar la interfaz: Una vez que todas las imágenes se han descargado, usa DispatchQueue.main.async para actualizar la UI en el hilo principal.



class ViewController2: UIViewController {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    var colaConcurrente = DispatchQueue.init(label: "colaConcurrente", attributes: .concurrent)
    var grupo = DispatchGroup()
    var semaforo = DispatchSemaphore(value: 1)
    
    var url: [String] = []
    
    func fetchImage(_ extra: String) -> String {
        semaforo.wait()
        sleep(2)
        semaforo.signal()
        return "ruta + \(extra)"
    }
    
    func setURLimage() {
        colaConcurrente.async(group: grupo) { [self] in
            grupo.enter()
            url.append(fetchImage("1"))
            grupo.leave()
            
        }
        
        colaConcurrente.async(group: grupo) { [self] in
            grupo.enter()
            url.append(fetchImage("2"))
            grupo.leave()
            
        }
        colaConcurrente.async(group: grupo) { [self] in
            grupo.enter()
            url.append(fetchImage("3"))
            grupo.leave()
            
        }
        
        grupo.notify(queue: .main) {
            self.table.reloadData()
        }
    }
}

extension ViewController2: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return url.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var celda = UITableViewCell()
        return celda
    }
}


var colaConcurrente = DispatchQueue.init(label: "colaConcurrente", attributes: .concurrent)
var grupo = DispatchGroup()
var semaforo2 = DispatchSemaphore(value: 1)

var url: [String] = []

func fetchImage(_ extra: String) -> String {
    semaforo2.wait()
    sleep(2)
    semaforo2.signal()
    return "ruta + \(extra)"
}

func setURLimage() {
    colaConcurrente.async(group: grupo) {
        grupo.enter()
        url.append(fetchImage("3"))
        grupo.leave()
        
    }
    
    colaConcurrente.async(group: grupo) {
        grupo.enter()
        url.append(fetchImage("1"))
        grupo.leave()
        
    }
    
    colaConcurrente.async(group: grupo) {
        grupo.enter()
        url.append(fetchImage("2"))
        grupo.leave()
        
    }
    
    grupo.notify(queue: .main) {
        print(url)
    }
}
setURLimage()
//: [Next](@next)
