//
//  VirtualObjectLoader.swift
//  zipa_final02
//
//  Created by Lydia Kara on 09/05/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import Foundation
import ARKit

/**
 Loads multiple `VirtualObject`s on a background queue to be able to display the
 objects quickly once they are needed.
 */
class VirtualObjectLoader {
    private(set) var loadedObjects = [VirtualObject]()
    
    private(set) var isLoading = false
    
    // MARK: - Loading object
    
    /**
     Loads a `VirtualObject` on a background queue. `loadedHandler` is invoked
     on a background queue once `object` has been loaded.
     */
    func loadVirtualObject(_ object: VirtualObject, loadedHandler: @escaping (VirtualObject) -> Void) {
        isLoading = true
        loadedObjects.append(object)
        
        // Load the content into the reference node.
        DispatchQueue.global(qos: .userInitiated).async {
            object.reset()
            object.load()
            self.isLoading = false
            loadedHandler(object)
        }
    }
    
    // MARK: - Removing Objects
    
    func removeAllVirtualObjects() {
        // Reverse the indices so we don't trample over indices as objects are removed.
        for index in loadedObjects.indices.reversed() {
            removeVirtualObject(at: index)
        }
    }
    
    func removeVirtualObject(at index: Int) {
        guard loadedObjects.indices.contains(index) else { return }
        
        loadedObjects[index].removeFromParentNode()
        loadedObjects[index].unload()
        loadedObjects.remove(at: index)
    }
}
