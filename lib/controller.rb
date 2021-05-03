require 'gossip'

class ApplicationController < Sinatra::Base
    #Affichage de la liste les gossips
    get '/' do
        erb:index, locals:{gossips: Gossip.all}
    end

    #Creation d'un nouveau gossip
	get '/gossips/new/' do
		erb:new_gossip
	end

    #Traitement du formulaire pour la creation de gossip
    post '/gossips/new/' do
        Gossip.new(params["gossip_content"], params["gossip_author"]).save
        redirect '/'
    end

    #Affichage d'un gossip (par id)
    get '/gossips/:id/' do
        id = params['id'].to_i
        p "-"*12
        p Gossip.all_comments[1]
        p "-"*12
        erb:show, locals:{gossip: Gossip.find(id), id: id, comments: Gossip.all_comments}
    end

    #Ajout d'un commentaire (par id)
    post '/gossips/:id/' do
        id = params['id'].to_i
        Gossip.save_comment(params["gossip_comment"], id)
        redirect '/'
    end

    #Modification d'un gossip (par id)
    get '/gossips/:id/edit/' do
        id = params['id'].to_i
        erb:edit, locals:{id:id}
    end

    #raitement du formulaire nouvreau gossip pour la modification d'un gossip (par id)
    post '/gossips/:id/edit/' do
        id = params['id'].to_i
        Gossip.update(params["gossip_content"], params["gossip_author"], id)
        redirect '/'
    end

    #binding.pry
    #Lancer le serveur avec Sinatra
    #run! if app_file == $0
end