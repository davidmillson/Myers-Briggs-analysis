library(aplpack)

#displays sample results
faces()

#read in the data
faces= read.csv("W:/Science Evidence and Analytics/Analytics/Operational Research/OR Non Project/Technical/Training/Programming/Myers Briggs.csv")

#display results using the data
faces(faces, face.type=1)

#create a new dataframe with variables assigned to the facial characteristics
faces1 = data.frame(height = faces$E,
                    width = faces$E,
                    structure = faces$J,
                    mouth_h = faces$E,
                    mouth_w = faces$E,
                    smiling = -faces$T,
                    eye_h = faces$S, 
                    eye_w = faces$S,
                    hair_h = 0,
                    hair_w = 0,
                    hair_s = 0,
                    nose_h = 0,
                    nose_w = 0,
                    ear_w = 0,
                    ear_h = 0)

#display the results
faces(faces1)

#add two new indivduals to set the limits of the variables, in order to centre around zero
faces = rbind(faces, c(60,60,60,60))
faces = rbind(faces, c(-60,-60,-60,-60))

#create a new mapping of variables to characteristics
faces1 = data.frame(height = faces$E+faces$J,
                    width = faces$E-faces$T,
                    structure = -faces$T,
                    mouth_h = 0,
                    mouth_w = 0,
                    smiling = -faces$T,
                    eye_h = faces$S, 
                    eye_w = faces$S,
                    hair_h = -faces$J,
                    hair_w = -faces$J,
                    hair_s = -faces$J,
                    nose_h = faces$S,
                    nose_w = faces$S,
                    ear_w = faces$S,
                    ear_h = faces$S)

#display the results without colour
faces(faces1,face.type=0)
