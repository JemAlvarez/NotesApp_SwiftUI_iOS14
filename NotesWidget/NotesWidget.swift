//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: NoteSelectorIntent())
    }

    func getSnapshot(for configuration: NoteSelectorIntent,in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: NoteSelectorIntent,in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: NoteSelectorIntent
}

struct NotesWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]

    var body: some View {
        if family == .systemMedium || family == .systemSmall {
            VStack (alignment: .leading, spacing: 10) {
                Text(entry.configuration.item?.noteTitle! ?? "---")
                    .lineLimit(1)
                    .font(.caption)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nulla nisl, imperdiet ut tristique at, faucibus et odio. Nullam blandit, odio id malesuada ultricies, augue lectus gravida metus, ac volutpat ante tortor ac tortor. Maecenas viverra enim in ex malesuada, ut iaculis velit rhoncus. Nam sagittis tellus quis scelerisque viverra.")
                    .lineLimit(4)
                    .font(.caption2)
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "star.slash.fill")
                        .foregroundColor(Color(.systemGray))
                    
                    Spacer()
                    
                    Image(systemName: "lock.fill")
                        .foregroundColor(.red)
                    
                    Spacer()
                    
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.green)
                    
                    Spacer()
                }
                .padding(3)
                .background(Color(.systemGray5))
                .cornerRadius(3)
                
                Text("Images: \(entry.configuration.item != nil ? "\(entry.configuration.item?.imagesNumber ?? 0)" : "-")")
                    .font(.footnote)
            }
            .padding(13)
        } else {
            LazyVGrid(columns: columns, spacing: 20) {
                VStack (alignment: .leading, spacing: 10) {
                    Text("Note Title")
                        .lineLimit(1)
                        .font(.caption)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nulla nisl, imperdiet ut tristique at, faucibus et odio. Nullam blandit, odio id malesuada ultricies, augue lectus gravida metus, ac volutpat ante tortor ac tortor. Maecenas viverra enim in ex malesuada, ut iaculis velit rhoncus. Nam sagittis tellus quis scelerisque viverra.")
                        .lineLimit(4)
                        .font(.caption2)
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: "star.slash.fill")
                            .foregroundColor(Color(.systemGray))
                        
                        Spacer()
                        
                        Image(systemName: "lock.fill")
                            .foregroundColor(.red)
                        
                        Spacer()
                        
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.green)
                        
                        Spacer()
                    }
                    .padding(3)
                    .background(Color(.systemGray5))
                    .cornerRadius(3)
                    
                    Text("Images: 3")
                        .font(.footnote)
                }
                .padding(10)
                .background(Color(.systemGray2))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 2)
                )
                
                VStack (alignment: .leading, spacing: 10) {
                    Text("Note Title")
                        .lineLimit(1)
                        .font(.caption)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nulla nisl, imperdiet ut tristique at, faucibus et odio. Nullam blandit, odio id malesuada ultricies, augue lectus gravida metus, ac volutpat ante tortor ac tortor. Maecenas viverra enim in ex malesuada, ut iaculis velit rhoncus. Nam sagittis tellus quis scelerisque viverra.")
                        .lineLimit(4)
                        .font(.caption2)
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Spacer()
                        
                        Image(systemName: "lock.fill")
                            .foregroundColor(.red)
                        
                        Spacer()
                        
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.blue)
                        
                        Spacer()
                    }
                    .padding(3)
                    .background(Color(.systemGray5))
                    .cornerRadius(3)
                    
                    Text("Images: 5")
                        .font(.footnote)
                }
                .padding(10)
                .background(Color(.systemGray2))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                )
                
                VStack (alignment: .leading, spacing: 10) {
                    Text("Note Title")
                        .lineLimit(1)
                        .font(.caption)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nulla nisl, imperdiet ut tristique at, faucibus et odio. Nullam blandit, odio id malesuada ultricies, augue lectus gravida metus, ac volutpat ante tortor ac tortor. Maecenas viverra enim in ex malesuada, ut iaculis velit rhoncus. Nam sagittis tellus quis scelerisque viverra.")
                        .lineLimit(4)
                        .font(.caption2)
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Spacer()
                        
                        Image(systemName: "lock.slash.fill")
                            .foregroundColor(Color(.systemGray))
                        
                        Spacer()
                        
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.purple)
                        
                        Spacer()
                    }
                    .padding(3)
                    .background(Color(.systemGray5))
                    .cornerRadius(3)
                    
                    Text("Images: 1")
                        .font(.footnote)
                }
                .padding(10)
                .background(Color(.systemGray2))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple, lineWidth: 2)
                )
                
                VStack (alignment: .leading, spacing: 10) {
                    Text("Note Title")
                        .lineLimit(1)
                        .font(.caption)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nulla nisl, imperdiet ut tristique at, faucibus et odio. Nullam blandit, odio id malesuada ultricies, augue lectus gravida metus, ac volutpat ante tortor ac tortor. Maecenas viverra enim in ex malesuada, ut iaculis velit rhoncus. Nam sagittis tellus quis scelerisque viverra.")
                        .lineLimit(4)
                        .font(.caption2)
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: "star.slash.fill")
                            .foregroundColor(Color(.systemGray))
                        
                        Spacer()
                        
                        Image(systemName: "lock.slash.fill")
                            .foregroundColor(Color(.systemGray))
                        
                        Spacer()
                        
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.orange)
                        
                        Spacer()
                    }
                    .padding(3)
                    .background(Color(.systemGray5))
                    .cornerRadius(3)
                    
                    Text("Images: 0")
                        .font(.footnote)
                }
                .padding(10)
                .background(Color(.systemGray2))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.orange, lineWidth: 2)
                )
            }
            .padding(13)
        }
    }
}

@main
struct NotesWidget: Widget {
    let kind: String = "NotesWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: NoteSelectorIntent.self, provider: Provider()) { entry in
            NotesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct NotesWidget_Previews: PreviewProvider {
    static var previews: some View {
        NotesWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: NoteSelectorIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
