require "apokochito/tictactoe/version"

module Apokochito
  module Tictactoe
    
#Basic file

class Tablero
  
  #Declarar a las todas las casillas vacias
  def tabvacio
    @uno = " "
    @dos = " "
    @tres = " "
    @cuatro = " "
    @cinco = " "
    @seis = " "
    @siete = " "
    @ocho = " "
    @nueve = " "
  end
  
  #Declarar los tiros disponibles a la computadora
  def computadora
    pc = [@uno,@dos,@tres,@cuatro,@cinco,@seis,@siete,@ocho,@nueve]
  end
  
  #Declarar cada casilla en blanco con su identificador
  def tiros
    @casillas = {
        "1" => @uno,
        "2" => @dos,
        "3" => @tres,
        "4" => @cuatro,
        "5" => @cinco,
        "6" => @seis,
        "7" => @siete,
        "8" => @ocho,
        "9" => @nueve
    }
  end
  
  #Las posibles soluciones de victoria
  def clave
    [[@uno,@dos,@tres],[@cuatro,@cinco,@seis],[@siete,@ocho,@nueve],[@uno,@cinco,@nueve],[@uno,@cuatro,@siete],[@dos,@cinco,@ocho],[@tres,@seis,@nueve],[@tres,@cinco,@siete]]
  end
  
  #Instrucciones al usuario del juego
  def instrucciones
  puts "¡Bienvenido a Tres en Raya, comenzamos!"
  puts "↓ Tablero base ↓"
  puts "  *************\n"
  puts   "  * 1 | 2 | 3 *",
         "  * --------- *",
         "  * 4 | 5 | 6 *",
         "  * --------- *",
         "  * 7 | 8 | 9 *"
    puts "  *************\n"
  end
  
  #Tablero dinamico donde los valores cambian depende los tiros del usuario y la computadora
  def tabjugador
  puts "    #{@uno} | #{@dos} | #{@tres}"
  puts "   ---|---|---"
  puts "    #{@cuatro} | #{@cinco} | #{@seis}"
  puts "   ---|---|---"
  puts "    #{@siete} | #{@ocho} | #{@nueve}"
  puts "  *************\n"
  end
  
  #Comprobacion de que el tiro esta disponible
  def posibletiro(tiro)
    if tiro == " " then
      true
    else
      enemigo
    end
  end
  
  #Tiro del usuario X
  def jugador
    puts "Escoge una casilla (1-9)"
    casilla = gets.chomp
    valid=/\d/.match(casilla)
    if valid != nil then
      tiros.each do |num,var|
        if casilla == num then
          #Regreso el tiro en str
          var.sub!(" ", "X")
        end
      end
    else
        puts "<< Ingresa un dígito válido entre 1-9 >>"
        jugador
    end
  end
  
  #Tiro del usuario computadora O
  def enemigo
    computadora.shuffle.each do |pc|
        posibletiro(pc)
        pc.gsub!(" ","O")
        break
    end
  end

  #condiciones de victoria, empate y perdida
  def ganador
    clave.each do |soluc|
      soluc.each do |index|
        if soluc[0] == "O" && soluc[1] == "O" && soluc[2] == "O" then
          puts "~~~~~~~¡Has perdido, quizá la próxima!~~~~~~~"
          puts "Quieres jugar de nuevo? <<(y/n)>>"
          resp = gets.chomp
          if resp == "y" or resp == "Y" then
            nuevo
          elsif resp == "n" or resp == "N" then
            exit 100
          end
        elsif soluc[0] == "X" && soluc[1] == "X" && soluc[2] == "X" then
          puts "~~~~~~~¡¡Has ganado!!~~~~~~~"
          puts "Quieres jugar de nuevo? <<(y/n)>>"
          resp = gets.chomp
          if resp == "y" or resp == "Y" then
            nuevo
          elsif resp == "n" or resp == "N" then
            exit 100
          end
        elsif @cont==5 && soluc[0] == "O" && soluc[1] == "O" && soluc[2] == "O" then
          puts "~~~~~~~¡Has perdido, quizá la próxima!~~~~~~~"
          puts "Quieres jugar de nuevo? <<(y/n)>>"
          resp = gets.chomp
          if resp == "y" or resp == "Y" then
            nuevo
          elsif resp == "n" or resp == "N" then
            exit 100
          end
        elsif @cont==5 then
          puts "Empate!"
          puts "Quieres jugar de nuevo? <<(y/n)>>"
          resp = gets.chomp
          if resp == "y" or resp == "Y" then
            nuevo
          elsif resp == "n" or resp == "N" then
            exit 100
          end
        end
      end
    end
  end

  #Iniciar una nueva partida
  def nuevo
  juego
  end

  #Estructura y orden del juego
  def juego
  @cont=0
  instrucciones
  tabvacio
    while true do
      @cont+=1
      jugador
      if @cont==5 then
        ganador
      end
      enemigo
      tabjugador
      if @cont>=3 then
        ganador
      end
    end
  end
end

#Inicio de la partida
tablero = Tablero.new
tablero.juego
  end
end
