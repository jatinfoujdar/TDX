import SwiftUI

struct RecentSearchesView: View {
    let items: [String]
    let onSelect: (String) -> Void
    let onClear: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Text("Recent Searches")
                    .font(.headline)
                
                Spacer()
                
                Button("Clear") { onClear() }
                    .font(.caption)
            }
            
            ForEach(items, id: \.self) { item in
                Button {
                    onSelect(item)
                } label: {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                        Text(item)
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(radius: 4)
    }
}

#Preview {
    RecentSearchesView(
        items: ["Avatar", "Batman", "Interstellar"],
        onSelect: { _ in },
        onClear: { }
    )
}
