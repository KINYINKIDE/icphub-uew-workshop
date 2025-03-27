import Option "mo:base/Option";

actor ToDoList {
  type Task = {
    title : Text;
    description : Text;
    isCompleted : Bool;
  };

  // Define Task as a stable type to ensure persistence across upgrades
  stable var currentTask : ?Task = null;

  // Function to add a new task
  public func addTask(title : Text, description : Text) : async Text {
    switch (currentTask) {
      case (null) {
        currentTask := ?{
          title = title;
          description = description;
          isCompleted = false;
        };
        return "Task added successfully";
      };
      case (?task) {
        if (task.isCompleted) {
          currentTask := ?{
            title = title;
            description = description;
            isCompleted = false;
          };
          return "Task added successfully";
        } else {
          return "You already have a task! Complete it before adding a new one.";
        };
      };
    };
  };

  // Function to mark the task as completed
  public func completeTask() : async Text {
    switch (currentTask) {
      case (null) {
        return "No task found!";
      };
      case (?task) {
        if (task.isCompleted) {
          return "Task is already marked!";
        } else {
          currentTask := ?{
            title = task.title;
            description = task.description;
            isCompleted = true;
          };
          return "Task is marked as complete!";
        };
      };
    };
  };

  // Function to view the current task
  public func viewTask() : async Text {
    switch (currentTask) {
      case (null) {
        return "📭 No task available.";
      };
      case (?task) {
        let status = if (task.isCompleted) { "Completed ✅" } else { "Pending ⏳" };
        return "📋 Task: " # task.title # "\n📝 Description: " # task.description # "\n📊 Status: " # status;
      };
    };
  };
}
