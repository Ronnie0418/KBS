(deftemplate smartphone
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio)
)

(deftemplate computadora
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio)
)

(deftemplate accesorio
   (slot tipo)
   (slot marca)
   (slot precio)
)

(deffacts smartphones
   (smartphone (marca "Apple") (modelo "iPhone 16") (color "Rojo") (precio 27000)) 
   (smartphone (marca "Samsung") (modelo "Galaxy Z Fold 5") (color "Negro") (precio 2599)) 
   (smartphone (marca "Google") (modelo "Pixel 8 Pro") (color "Blanco") (precio 1099))
   (smartphone (marca "OnePlus") (modelo "11 5G") (color "Verde") (precio 999))
   (smartphone (marca "Xiaomi") (modelo "Redmi Note 13") (color "Azul") (precio 399))
   (smartphone (marca "Motorola") (modelo "Edge 40") (color "Verde") (precio 749))
)

(deffacts computadoras
   (computadora (marca "Dell") (modelo "Alienware M16") (color "Gris") (precio 2299)) 
   (computadora (marca "HP") (modelo "Omen 16") (color "Negro") (precio 1899))
   (computadora (marca "Lenovo") (modelo "Legion 5 Pro") (color "Plata") (precio 1699))
   (computadora (marca "Asus") (modelo "ROG Zephyrus G14") (color "Blanco") (precio 1799))
   (computadora (marca "Apple") (modelo "MacBook Air M2") (color "Espacio Gris") (precio 1299))
)

(deffacts accesorios
   (accesorio (tipo "Auriculares") (marca "Bose") (precio 399))
   (accesorio (tipo "Teclado") (marca "Corsair") (precio 129))
   (accesorio (tipo "Ratón") (marca "Logitech") (precio 59))
   (accesorio (tipo "Monitor") (marca "Samsung") (precio 299))
   (accesorio (tipo "Cargador") (marca "Anker") (precio 35))
   (accesorio (tipo "Funda") (marca "Spigen") (precio 19))
   (accesorio (tipo "Soporte para portátil") (marca "Ergotron") (precio 129))
   (accesorio (tipo "Disco Duro Externo") (marca "Western Digital") (precio 119))
)

(deftemplate cliente
   (slot id)
   (slot nombre)
   (slot edad)
   (slot telefono)
)

(deffacts clientes
   (cliente (id 1) (nombre "Carlos Pérez") (edad 30) (telefono "555-4321"))
   (cliente (id 2) (nombre "Sandra López") (edad 28) (telefono "555-8765"))
   (cliente (id 3) (nombre "Jorge García") (edad 35) (telefono "555-1234"))
   (cliente (id 4) (nombre "Patricia Martínez") (edad 22) (telefono "555-6789"))
   (cliente (id 5) (nombre "Miguel Rodríguez") (edad 40) (telefono "555-9876"))
)

(deftemplate tarjeta-credito
   (slot id)
   (slot numero)
   (slot titular)
   (slot banco)
   (slot grupo)
)

(deffacts tarjetas-credito
   (tarjeta-credito (id 1) (numero "1111-2222-3333-4444") (titular "Carlos Pérez") (banco "Santander") (grupo "Visa"))
   (tarjeta-credito (id 2) (numero "5555-6666-7777-8888") (titular "Sandra López") (banco "Banorte") (grupo "Mastercard"))
   (tarjeta-credito (id 3) (numero "2222-3333-4444-5555") (titular "Jorge García") (banco "BBVA") (grupo "Visa"))
   (tarjeta-credito (id 4) (numero "9999-0000-1111-2222") (titular "Patricia Martínez") (banco "Citibanamex") (grupo "Mastercard"))
   (tarjeta-credito (id 5) (numero "7777-4444-8888-3333") (titular "Miguel Rodríguez") (banco "HSBC") (grupo "Visa"))
)

(deftemplate vale
   (slot codigo)
   (slot titular)
   (slot descripcion)
)

(deffacts vales
   (vale (codigo "CUPON15") (titular "Carlos Pérez") (descripcion "15% Descuento en computadoras"))
   (vale (codigo "GADGET10") (titular "Sandra López") (descripcion "10% en accesorios"))
   (vale (codigo "BONUS20") (titular "Jorge García") (descripcion "20% en próximos productos"))
)

(deftemplate orden-compra
   (slot cliente-id)
   (slot nombre-cliente)
   (slot telefono)
   (multislot producto)
   (slot cantidad)
   (slot metodo-pago)
)

(deffacts ordenes-compra
   (orden-compra (cliente-id 1) (nombre-cliente "Carlos Pérez") (telefono "555-4321") (producto smartphone "Samsung" "Galaxy Z Fold 5" 2599) (cantidad 2) (metodo-pago "tarjeta"))
   (orden-compra (cliente-id 2) (nombre-cliente "Sandra López") (telefono "555-8765") (producto computadora "Dell" "Alienware M16" 2299) (cantidad 1) (metodo-pago "contado"))
   (orden-compra (cliente-id 3) (nombre-cliente "Jorge García") (telefono "555-1234") (producto accesorio "Logitech" "Ratón" 59) (cantidad 1) (metodo-pago "tarjeta"))
   (orden-compra (cliente-id 4) (nombre-cliente "Patricia Martínez") (telefono "555-6789") (producto smartphone "Google" "Pixel 8 Pro" 1099) (cantidad 1) (metodo-pago "tarjeta"))
   (orden-compra (cliente-id 5) (nombre-cliente "Miguel Rodríguez") (telefono "555-9876") (producto smartphone "Apple" "iPhone 16" 27000) (cantidad 3) (metodo-pago "tarjeta"))
)

; Reglas como antes, sólo que con datos nuevos.

;1
(defrule cliente-compra-grande
    (orden-compra (nombre-cliente ?nombre) (cantidad ?cantidad&:(> ?cantidad 15)))
    (not (compro mas-15 ?nombre))
    =>
    (printout t "El cliente " ?nombre " ha comprado más de 15 productos" crlf)
    (assert (compro mas-15 ?nombre))
)

;2
(defrule comprador-frecuente
    (orden-compra (nombre-cliente ?nombre) (cantidad ?cantidad&:(> ?cantidad 15)))
    (compro mas-15 ?nombre)
    (not (es vip ?nombre))
    =>
    (printout t "El cliente " ?nombre " es un comprador frecuente por comprar más de 15 productos varias veces" crlf)
    (assert (es vip ?nombre))
)

;3
(defrule comprador-normal
    (orden-compra (nombre-cliente ?nombre) (cantidad ?cantidad&:(<= ?cantidad 15)))
    (not (es vip ?nombre))
    =>
    (printout t "El cliente " ?nombre " ha comprado menos de 15 productos y es un comprador ocasional" crlf)
    (assert (es ocasional ?nombre))
)

;4
(defrule generar-descuento-primer-compra
    (cliente (nombre ?nombre))
    (not (orden-compra (nombre-cliente ?nombre)))
    =>
    (printout t "Aprovecha " ?nombre " y haz tu primera compra con 15% de descuento" crlf)
    (assert (vale (codigo "PRIMERACOMPRA") (titular ?nombre) (descripcion "Descuento del 15% en tu primera compra")))
)

;5
(defrule generar-vale-pago-tarjeta-bbva
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (cliente-id ?id) (metodo-pago "tarjeta"))
    (tarjeta-credito (titular ?nombre) (banco "BBVA"))
    (not (vale (codigo "BBVADOBLE") (titular ?nombre) (descripcion "30% en Puntos Dobles en tu próxima compra")))
    =>
    (printout t ?nombre " Por comprar con TDC BBVA, recibe 30% de Puntos Dobles en tu próxima compra" crlf)
    (assert (vale (codigo "BBVADOBLE") (titular ?nombre) (descripcion "30% en Puntos Dobles en tu próxima compra")))
)

;6
(defrule generar-descuento-compra-contado
    (cliente (nombre ?nombre) (telefono ?telefono))
    (orden-compra (nombre-cliente ?nombre) (metodo-pago "contado"))
    (not (orden-compra (nombre-cliente ?nombre) (metodo-pago "tarjeta")))
    =>
    (assert (vale (codigo "TDCPRIMERAVEZ") (titular ?nombre) (descripcion "Vale por 10% de descuento en tu próxima compra usando tarjeta")))
    (printout t ?nombre " Usa tu tarjeta y aprovecha 10% de descuento en tu próxima compra" crlf)
)

;7
(defrule cliente-compro-electrodomesticos
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (producto electrodomestico $?))
    (not (compro electrodomestico ?nombre))
    =>
    (printout t "El cliente " ?nombre " ha comprado un electrodoméstico." crlf)
    (assert (compro electrodomestico ?nombre))
)

;8
(defrule cliente-compro-electrodomesticos-dos-veces
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (producto electrodomestico $?))
    (compro electrodomestico ?nombre)
    =>
    (printout t "El cliente " ?nombre " ha comprado electrodomésticos al menos dos veces." crlf)
    (assert (consume electrodomesticos ?nombre))
)

;9
(defrule cliente-compro-productos-tecnologicos
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (producto tecnologia $?))
    (not (compro tecnologia ?nombre))
    =>
    (printout t "El cliente " ?nombre " ha comprado un producto tecnológico." crlf)
    (assert (compro tecnologia ?nombre))
)

;10
(defrule cliente-compro-productos-tecnologicos-dos-veces
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (producto tecnologia $?))
    (compro tecnologia ?nombre)
    =>
    (printout t "El cliente " ?nombre " ha comprado productos tecnológicos al menos dos veces." crlf)
    (assert (consume tecnologia ?nombre))
)

;11
(defrule cliente-compro-muebles
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (producto mueble $?))
    (not (compro mueble ?nombre))
    =>
    (printout t "El cliente " ?nombre " ha comprado un mueble." crlf)
    (assert (compro mueble ?nombre))
)

;12
(defrule cliente-compro-muebles-dos-veces
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (producto mueble $?))
    (compro mueble ?nombre)
    =>
    (printout t "El cliente " ?nombre " ha comprado muebles al menos dos veces." crlf)
    (assert (consume muebles ?nombre))
)

;13
(defrule descuento-comprador-frecuente
    (es vip ?nombre)
    =>
    (printout t ?nombre " Como comprador frecuente, te damos un 15% de descuento en tu próxima compra de más de 5 productos." crlf)
    (assert (vale (codigo "VIPDISCOUNT")(titular ?nombre) (descripcion "15% de descuento en compras de más de 5 productos")))
)

;14
(defrule generacion-vale-pago-mastercard
   (tarjeta-credito (titular ?nombre) (grupo "Mastercard"))
   =>
   (printout t ?nombre " Usa tu TDC Mastercard para aprovechar el 15% de descuento en tu próxima compra." crlf)
   (assert (vale (codigo "MASTER15")(titular ?nombre) (descripcion "15% de descuento en tu próxima compra con Mastercard")))
)

;15
(defrule oferta-mastercard-electrodomestico
   (tarjeta-credito (titular ?nombre) (grupo "Mastercard"))
   (orden-compra (nombre-cliente ?nombre) (producto electrodomestico $?))
   =>
   (printout t ?nombre " Por comprar un electrodoméstico, ahora obtienes 10% de descuento usando tu TDC Mastercard." crlf)
   (assert (vale (codigo "MASTERELECTRO")(titular ?nombre) (descripcion "10% de descuento en electrodomésticos con Mastercard")))
)

;16
(defrule generacion-oferta-express
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (cliente-id ?id) (metodo-pago "tarjeta"))
    (tarjeta-credito (titular ?nombre) (banco "American Express"))
    =>
    (printout t ?nombre " Por comprar con TDC American Express, obtienes 10% de cashback en tu próxima compra." crlf)
    (assert (vale (codigo "AE10CASHBACK")(titular ?nombre) (descripcion "10% de cashback con American Express en tu próxima compra")))
)

;17
(defrule oferta-liverpool-pago-diferido
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (cliente-id ?id) (metodo-pago "tarjeta"))
    (tarjeta-credito (titular ?nombre) (banco "Liverpool"))
    =>
    (printout t ?nombre " Con tu TDC Liverpool, tendrás pago diferido de 3 meses en tu próxima compra." crlf)
    (assert (vale (codigo "LIVERPOOL3MES")(titular ?nombre) (descripcion "Pago diferido de 3 meses con Liverpool")))
)

;18
(defrule hsbc-descuento
    (cliente (nombre ?nombre))
    (orden-compra (nombre-cliente ?nombre) (cliente-id ?id) (metodo-pago "tarjeta"))
    (tarjeta-credito (titular ?nombre) (banco "HSBC"))
    =>
    (printout t ?nombre " Por comprar con TDC HSBC, obtienes 15% de descuento en tu próxima compra." crlf)
    (assert (vale (codigo "HSBCDISCOUNT")(titular ?nombre) (descripcion "15% de descuento usando TDC HSBC en próxima compra")))
)

;19
(defrule oferta-vendedor-casual
    (es ocasional ?nombre)
    =>
    (printout t ?nombre " Como vendedor ocasional, obtendrás un 5% de descuento si compras más de 5 unidades de un producto." crlf)
    (assert (vale (codigo "CASUAL5")(titular ?nombre) (descripcion "5% de descuento por comprar más de 5 unidades")))
)

;20
(defrule oferta-envio-gratis-mayor-500
   (orden-compra (nombre-cliente ?nombre) (producto ?tipo ?marca ?modelo ?precio&:(> ?precio 499)))
   =>
   (printout t "Tu envío será gratis por la compra mayor a 499" crlf)
)


