//
//  TasksInDepth.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/22/22.
//

import SwiftUI

/**
 This is where we will deep dive into Tasks and how we can use them with async and await more!
 */
class TasksViewModel : ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                let image = UIImage(data: data)
                self.image = image
            }
        } catch {
            print(error.localizedDescription)
        }
        
        /**
         try Task.checkCancellation() to check for cancellation on certain tasks when the task is long.
         */
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                let image2 = UIImage(data: data)
                self.image2 = image2
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

/**
 Priority is very dependent on what it is you are trying to accomplish.
 
 We can also cancel tasks with .cancel() method. However, SwiftUI automatically cancels
 the task if the view disappears before the action completes. You might have to check for cancellation
 when you have a long task.
 
 We can also call task using .task {} instead of Task.
 */
struct TasksInDepth: View {
    
    @StateObject private var viewModel = TasksViewModel()
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image2 = viewModel.image2 {
                Image(uiImage: image2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }.onAppear { // Tasks have multiple different priority options and they depend on order:
            // we could use .task {} also.
            Task(priority: .low) {
                try? await Task.sleep(nanoseconds: 1_000_000_000) // just a sleep example
                print("Low: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .medium) {
                await Task.yield() // we can also yield to certain priorities.
                print("Medium: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .high) {
                print("High: \(Thread.current) : \(Task.currentPriority)")
                
                /*
                 Child tasks have the same priority and properties as the parent.
                 */
                Task {
                    print("Child task: \(Thread.current) : \(Task.currentPriority)")
                }
                /*
                 Child tasks can also be detached, however it is not recommended by Apple.
                 */
                Task.detached() {
                    print("Child task: \(Thread.current) : \(Task.currentPriority)")
                }
            }
            Task(priority: .background) {
                print("Background: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .utility) {
                print("Utility: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .userInitiated) {
                print("UserInitiated: \(Thread.current) : \(Task.currentPriority)")
            }
//            Task {
//                print(Thread.current)
//                print(Task.currentPriority)
//                await viewModel.fetchImage()
//            }
//            Task { // we can have multiple tasks running at the same time.
//                print(Thread.current)
//                print(Task.currentPriority)
//                await viewModel.fetchImage2()
//            }
        }
    }
}

struct TasksInDepth_Previews: PreviewProvider {
    static var previews: some View {
        TasksInDepth()
    }
}
