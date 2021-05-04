class Gossip
    attr_accessor :author, :content

    def initialize(content, author)
        @content = content
        @author = author
    end

    #Ajoute un nouveau gossip
    def save
        CSV.open('./db/gossip.csv', 'ab') do |csv|
            csv << [@content, @author]
        end
    end

    #Ajoute un nouveau commentaire
    def self.save_comment(comment, id)
        CSV.open('./db/comment.csv', 'ab') do |csv|
            csv << [id, comment]
        end
    end

    #Liste les gossips
    def self.all
        all_gossips = []
        CSV.read('./db/gossip.csv').each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    #Liste les gossips
    def self.all_comments
        all_comments = []
        CSV.read('./db/comment.csv').each do |csv_line|
            all_comments << [csv_line[0], csv_line[1]]
        end
        return all_comments
    end

    #Cherche un gossip (par id)
    def self.find(id)
        return Gossip.all[id]
    end

    #Modifie un nouveau gossip
    def self.update(content, author, id)
        all_gossips = Gossip.all
        all_gossips[id.to_i].content = content
        all_gossips[id.to_i].author = author

        CSV.open('./db/gossip.csv', 'w') do |csv|
            all_gossips.each do |gossip|
                csv << [gossip.content, gossip.author]
            end
        end
    end

    #Ajoute un commentaire
    def self.comment(id, comment)
        CSV.open('./db/comment.csv', 'ab') do |csv|
            csv << [id.to_i, comment]
        end
    end
end