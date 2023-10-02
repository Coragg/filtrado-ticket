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


function write_file(file_name::String, data::Vector)
    #= creation of the file .sal =#
    try
        sal_file = change_name_to_sal(file_name)
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

change_name_to_sal(file_name::String) = split(file_name, ".")[1] * ".sal"
