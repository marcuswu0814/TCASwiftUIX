//
//  ContentView.swift
//  TCASwiftUIX
//
//  Created by Marcus Wu on 2024/2/2.
//

import ComposableArchitecture
import SwiftUI
import SwiftUIX

// MARK: -

@Reducer
struct Feature: Reducer {
    
    @ObservableState
    struct State: Equatable {
        
        var pages: IdentifiedArrayOf<Page.State> = [
            .init(id: 0),
            .init(id: 1),
            .init(id: 2)
        ]
        
    }
    
    enum Action {
        
        case pages(IdentifiedActionOf<Page>)
        
    }
    
    var body: some Reducer<State, Action> {
        Reduce(core)
            .forEach(\.pages, action: \.pages) {
                Page()
            }
    }
    
    private func core(_ state: inout State, action: Action) -> Effect<Action> {
        switch action {
        default: break
        }
        
        return .none
    }
    
}

struct ContentView: View {
    
    let store: StoreOf<Feature>
    
    var body: some View {
        PaginationView(
            axis: .vertical,
            showsIndicators: false
        ) {
            /// ✅ Work as expected.
            ForEach(store.pages) { page in
                PageView(
                    store: .init(initialState: .init(id: page.id)) {
                    Page()
                })
            }
        }
    }
    
}

struct WrongContentView: View {
    
    let store: StoreOf<Feature>
    
    var body: some View {
        PaginationView(
            axis: .vertical,
            showsIndicators: false
        ) {
            /// ⚠️ Not Work as expected.
            ForEach(store.scope(state: \.pages, action: \.pages)) { store in
                PageView(store: store)
            }
        }
    }
    
}

// MARK: -

@Reducer
struct Page: Reducer {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        
        let id: Int
        
    }
    
    enum Action {}
    
    var body: some Reducer<State, Action> {
        Reduce(core)
    }
    
    private func core(_ state: inout State, action: Action) -> Effect<Action> {
        switch action {
        default: break
        }
        
        return .none
    }
    
}

struct PageView: View {
    
    let store: StoreOf<Page>
    
    var body: some View {
        switch store.state.id {
        case 0: Color.red
        case 1: Color.green
        case 2: Color.blue
        default: Color.black
        }
    }
    
}

// MARK: - Preview

#Preview {
    ContentView(store: .init(initialState: .init()) {
        Feature()
    })
}

#Preview {
    WrongContentView(store: .init(initialState: .init()) {
        Feature()
    })
}
