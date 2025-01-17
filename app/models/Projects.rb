class Projects
    # HARD CODED project names, blurbs, and image urls
    def choose(amount = 0)

=begin
        project_0 = {:name => "Automated Job Search", :imgurl => "projects/project_0.png",
            :blurb => "Learn about the wonders of web scraping, APIs, and database management."}
        project_1 = {:name => "iOS Game Dev", :imgurl => "projects/project_1.png",
            :blurb => "Project members will learn how to use XCode and SWIFT to develop an iOS game."}
        project_2 = {:name => "Tensorflow Object Detection", :imgurl => "projects/project_2.png",
            :blurb => "Tensorflow based detection adapted to track custom objects through live video."}
        project_3 = {:name => "Receipt Reader", :imgurl => "projects/project_3.png",
            :blurb => "Use Google Vision API and RegEx to parse receipt image and split a bill among friends."}
        project_4 = {:name => "Audio Visualizer", :imgurl => "projects/project_4.png",
            :blurb => "Python based visualizer that reads input from a microphone and reacts to the sound."}
        project_5 = {:name => "Megaman Infinite Runner", :imgurl => "projects/project_5.png",
            :blurb => "Unity-based 2D Endless Runner Platformer using Megaman X sprites."}
        project_6 = {:name => "Portfolio Design & Dev", :imgurl => "projects/project_6.png",
            :blurb => "Design sprint and development with HTML/CSS/JS to create a deployable online portfolio for recruitment."}
=end
        project_0 = {:name => "Personal Website", :imgurl => "projects/portfolio.jpg",
            :blurb => "Build your own cool, personal website from scratch using HTML, CSS, JavaScript, and jQuery!"}
        project_1 = {:name => "Music Generation", :imgurl => "projects/musicGeneration.jpg",
            :blurb => "Explore introductory ML and neural network concepts and apply your newfound knowledge to generate your own music!"}
        project_2 = {:name => "Whatcha Wanna Do", :imgurl => "projects/whatchaWanna.jpg",
            :blurb => "Bored and not sure what you want to do? This website searches through Eventbrite to create a schedule for you to get out there and explore!"}
        project_3 = {:name => "Unity Development", :imgurl => "projects/unityDev.jpg",
            :blurb => "Learn game development with a team of other developers using C# and Unity."}
        project_4 = {:name => "Movie Recommendations", :imgurl => "projects/movieRecs.jpg",
            :blurb => "Build a movie recommendation engine using filtering algorithms and visualize it on an interactive Tableau dashboard."}
        project_5 = {:name => "Web Reacts Only", :imgurl => "projects/webReacts.jpg",
            :blurb => "Learn how to start building basic Web apps with a focus on React and API calls!"}
        project_6 = {:name => "Rethinking CS", :imgurl => "projects/bigBrain.jpg",
            :blurb => "Learn about what goes into the process of designing an app! We will cover topics like ui/ux, design theory, user interaction, and much more!"}

            array = [project_0, project_1, project_2, project_3, project_4, project_5, project_6]
        if amount == 3 then
            seed = rand(9)
            toReturn = []
            toReturn.push(array[seed], array[(seed + 3) % 7], array[(seed + 6) % 7])
        else
            toReturn = array
        end
        return toReturn
    end
end
