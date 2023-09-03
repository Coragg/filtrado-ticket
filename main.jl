#= Definir los ganadores de las entradas si pideron:
    * Pidieron 1 o 2 entradas, se les asigna la cantidad de entradas pedidas.
    * Pidieron 3 a 7 entradas, se les asigna 2 entradas.
    * Pidieron 8 a 15 entradas, se les asigna 1 entrada.
    * Pidieron más de 15 entradas, no se les asigna ninguna entrada.
=#

function change_infortation(first::String, second :: String)
    first = parse(UInt8, first)
    second = parse(UInt8, second)
    suma = first + second
    return string(suma)
end


function delete_repeat_data(data::Vector)
    #= delete that repeat rut =#
    index = 1
    while index <= length(data)
        second_index = index + 1
        while second_index <= length(data)
            if data[index][1] == data[second_index][1]
                data[index][3] = change_infortation(string(data[index][3]), string(data[second_index][3]))
                deleteat!(data, second_index)
            end
            second_index += 1
        end
        index += 1
    end
    return data
end


function penalty_tycket(ticket::UInt8)
    #= filtration of the file =#
    if ticket >= 1 && ticket <= 2
        return ticket
    elseif ticket >= 3 && ticket <= 7
        return 2
    elseif ticket >= 8 && ticket <= 15
        return 1
    else
        return 0    
    end
end


function filter_tickets(data::Vector) 
    data = delete_repeat_data(data)
    index = 1
    while index <= length(data)
        data[index][3] = string(penalty_tycket(parse(UInt8, data[index][3])))
        index += 1
    end
    return data
end


function generate_matrix_3xn(data:: Vector{String})
    return [split(line, ",") for line in data]
end 


function read_file(file_name::String)
    try
        file = open(file_name, "r")
        lines = readlines(file)
        return lines
    catch 
        println("Error al leer el archivo $file_name.")
        exit()
    end
end


function generate_and_filter_data(name_file::String)
    data = read_file(name_file)
    return generate_matrix_3xn(data)
end


function new_name(file_name::String)
    #= change the extension of the file to .sal
    param file_name: String of the file =#
   return split(file_name, ".")[1] * ".sal"
end


function write_file(file_name::String, data::Vector)
    #= creation of the file .sal =#
    try
        sal_file = new_name(file_name)
        file = open(sal_file, "w")
        for line in data
            write(file, join(line, ",") * "\n")
        end
        close(file)
        println("Se a creado el archivo $sal_file ")
    catch
        println("Error al escribir el archivo $file_name.")
        exit()
    end
end


function main()
    println("Bienvenido a LollaPalooza")
    print("Ingrese el nombre del archivo de entrada: ")
    file_name = readline()
    data = generate_and_filter_data(file_name)
    data = filter_tickets(data)
    write_file(file_name, data)
end


main()