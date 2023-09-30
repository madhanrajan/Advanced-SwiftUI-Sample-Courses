//
//  FallingSnow.swift
//  Pro SwiftUI
//
//  Created by Madhan on 21/09/2023.
//

import SwiftUI

class FSParticle {
    var x: Double = 0.0
    var y: Double
    let xSpeed: Double
    let ySpeed: Double
    
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 2
    
    init(x: Double, y: Double, xSpeed: Double, ySpeed: Double) {
        self.x = x
        self.y = y
        self.xSpeed = xSpeed
        self.ySpeed = ySpeed
    }
}

class FSParticleSystem{
    
    var particles = [FSParticle]()
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate
    
    func update(date: TimeInterval, size: CGSize){
        let delta = date - lastUpdate
        lastUpdate = date
        
        let newParticle = FSParticle(x: .random(in: -32...size.width), y: -32, xSpeed: .random(in: -50...50), ySpeed: .random(in: 100...500))
        
        for (index, particle) in particles.enumerated() {
            if particle.deathDate < date{
                particles.remove(at: index)
            }else{
                particle.x += particle.xSpeed * delta
                particle.y += particle.ySpeed * delta
            }
        }
        
        particles.append(newParticle)
    }
}

struct FallingSnow: View {
    
    @State private var particleSystem = FSParticleSystem()
    
    var body: some View {
        
        LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom).mask{
            TimelineView(.animation){ timeline in
                Canvas{ ctx, size in
                    let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                    particleSystem.update(date: timelineDate, size: size)
                    ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))
                    ctx.addFilter(.blur(radius: 10))
                    
                    ctx.drawLayer { ctx1 in
                        for particle in particleSystem.particles {
                            ctx1.opacity = particle.deathDate - timelineDate
                            ctx1.fill(Circle().path(in: CGRect(x: particle.x, y: particle.y, width: 32, height: 32)), with: .color(.white))
                        }
                    }
                    
                    
                }
            }
        }
        
        
        .ignoresSafeArea()
        .background(.black)
    }
}

#Preview {
    FallingSnow()
}
