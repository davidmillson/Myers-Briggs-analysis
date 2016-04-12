library(dplyr)
library(tidyr)
library(igraph)

data = read.csv("W:/Science Evidence and Analytics/Analytics/Operational Research/OR Non Project/Technical/Training/Programming/Myers Briggs.csv")

#give each person a name based on their type
names = c("ENTJ1", "ESTJ", "ENTJ2", "INFJ", "ISTJ1", "INTP1", "ISTJ2", "ISTP", "ISTJ3", "INTJ", "INTP2", "INTP3", "INTP4", "ISTJ", "INTP5")
row.names(data) = names

#define a function to find the squared distance between two people, by summing the squared distance along each axis 
distance_squared = function(name1, name2){
  (data[name1,"E"]-data[name2,"E"])^2 +
    (data[name1,"S"]-data[name2,"S"])^2 +
    (data[name1,"T"]-data[name2,"T"])^2 +
    (data[name1,"J"]-data[name2,"J"])^2
}
#define a function to find the distance, by taking the root of the squared distance
distance = function(name1, name2){
  sqrt(distance_squared(name1, name2))
}

#run distance for each combination of names and turn into a dataframe
df = as.data.frame(sapply(names, distance, name2 = names))

#check which names are within 50.4 units of each other and class these as connected
df1 = as.data.frame(df<50.4) %>% mutate(name1 = names)

#gather the the connections into long form
df2 = df1 %>% gather(name2,connection,-name1)

#filter out any pairs which aren't connected, and the trivial pairs where a name is connected to itself, then ditch the connection column
df3 = df2 %>% filter(connection, name1!=name2) %>% select(-connection)

#create the network
network=graph.data.frame(df3, directed=F)

#colour the nodes gray and make them bigger
V(network)$color = 'gray'
V(network)$size = 20

#plot the network with font size reduced to fit in the nodes
plot(network, vertex.label.cex=0.8)
