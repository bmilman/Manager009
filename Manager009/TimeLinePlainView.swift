//
//  TimeLinePlainView.swift
//  Manager009
//
//  Created by bernard milman on 1/10/26.
//

import SwiftUI

struct TimeLinePlainView: View {
    
    // Configure your time window
    let start: Date
    let end: Date
   // @Binding var scrollPosition: ScrollPosition


    // Visual scale: points per minute (zoom level)
    @State private var pointsPerMinute: CGFloat = 4
    
    // Tick configuration
    private let majorTickInterval: TimeInterval = 60 * 60   // 1 hour
    private let minorTickInterval: TimeInterval = 15 * 60   // 15 minutes
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            TimelineContent(
                start: start,
                end: end,
                pointsPerMinute: pointsPerMinute,
                majorTickInterval: majorTickInterval,
                minorTickInterval: minorTickInterval
            )
            .padding(.vertical, 12)
            .background(Color(.systemGroupedBackground))
        }
        //.scrollPosition($scrollPosition)
        .overlay(alignment: .topTrailing) {
            // Simple zoom controls
            HStack(spacing: 8) {
                Button("-", systemImage: "minus.magnifyingglass") {
                    pointsPerMinute = max(2, pointsPerMinute * 0.8)
                }
                Button("+", systemImage: "plus.magnifyingglass") {
                    pointsPerMinute = min(60, pointsPerMinute * 1.25)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

private struct TimelineContent: View {
    let start: Date
    let end: Date
    let pointsPerMinute: CGFloat
    let majorTickInterval: TimeInterval
    let minorTickInterval: TimeInterval
    
    private var totalMinutes: CGFloat {
        CGFloat(end.timeIntervalSince(start) / 60.0)
    }
    
    private var contentWidth: CGFloat {
        totalMinutes * pointsPerMinute
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Baseline
            Rectangle()
                //.fill(Color(.red))
                .fill(Color.secondary.opacity(0.4))
                //.frame(height: 200)
                .offset(y: 40)
            
            // Minor ticks
            TicksView(
                start: start,
                end: end,
                interval: minorTickInterval,
                height: 10,
                color: .secondary.opacity(0.5),
                pointsPerMinute: pointsPerMinute
            )
            .offset(y: 10)
            
            // Major ticks + labels
            TicksView(
                start: start,
                end: end,
                interval: majorTickInterval,
                height: 999,
                color: .primary,
                pointsPerMinute: pointsPerMinute
            )
            .overlay(alignment: .topLeading) {
                LabelsView(
                    start: start,
                    end: end,
                    interval: majorTickInterval,
                    pointsPerMinute: pointsPerMinute
                )
                .offset(y: -8)
            }
        }
        .frame(width: contentWidth, alignment: .topLeading)
        .contentShape(Rectangle())
    }
}

private struct TicksView: View {
    let start: Date
    let end: Date
    let interval: TimeInterval
    let height: CGFloat
    let color: Color
    let pointsPerMinute: CGFloat
    
    var body: some View {
        let count = Int((end.timeIntervalSince(start) / interval).rounded(.down)) + 1
        
        Canvas { context, size in
            for i in 0..<count {
                let tickDate = start.addingTimeInterval(TimeInterval(i) * interval)
                let x = xPosition(for: tickDate)
                
                let path = Path { p in
                    p.move(to: CGPoint(x: x, y: 0))
                    p.addLine(to: CGPoint(x: x, y: height))
                }
                context.stroke(path, with: .color(color), lineWidth: 1)
            }
        }
        .frame(height: height)
    }
    
    private func xPosition(for date: Date) -> CGFloat {
        let minutes = CGFloat(date.timeIntervalSince(start) / 60.0)
        return minutes * pointsPerMinute
    }
}

private struct LabelsView: View {
    let start: Date
    let end: Date
    let interval: TimeInterval
    let pointsPerMinute: CGFloat
    
    private var formatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }
    
    var body: some View {
        let count = Int((end.timeIntervalSince(start) / interval).rounded(.down)) + 1
        
        ZStack(alignment: .topLeading) {
            ForEach(0..<count, id: \.self) { i in
                let tickDate = start.addingTimeInterval(TimeInterval(i) * interval)
                Text(formatter.string(from: tickDate))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .position(x: xPosition(for: tickDate), y: 0)
            }
        }
        .frame(width: totalWidth, height: 1, alignment: .topLeading)
    }
    
    private var totalWidth: CGFloat {
        let totalMinutes = CGFloat(end.timeIntervalSince(start) / 60.0)
        return totalMinutes * pointsPerMinute
    }
    
    private func xPosition(for date: Date) -> CGFloat {
        let minutes = CGFloat(date.timeIntervalSince(start) / 60.0)
        return minutes * pointsPerMinute
    }
    
}

//#Preview {
//    TimeLinePlainView(start: Date(timeIntervalSinceNow: -86400), end: .now)
//}

