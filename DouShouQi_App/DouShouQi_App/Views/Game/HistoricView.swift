import SwiftUI

struct HistoricView: View {
    
    @ObservedObject var historicListVM: HistoricListVM
    
    var body: some View {
        VStack {
            TitlePageFrame(Text: "Historic", ImageWidth: 200, ImageHeight: 200)
                .padding(.bottom, 20)
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(historicListVM.groupByDate().sorted(by: { $0.key > $1.key }), id: \.key) { key, historicVMs in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(formatDate(key))
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            ForEach(historicVMs) { historicVM in
                                GameResumeFrame(historicVm: historicVM)
                                    .padding(.bottom, 5)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.top, 10)
            }
            
            Spacer()
        }
    }
    
    // Fonction pour formater la date
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adapter le format si nécessaire
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: date)
        }
        return dateString
    }
}

struct HistoricView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricView(historicListVM: HistoricListVM())
    }
}
