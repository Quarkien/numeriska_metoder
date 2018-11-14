function main(n_cars, dist_cars, t_interval, n_steps , fun_g)
    function ds = speed_dep_dist(x1, x2)
        if (x2-x1) < 75
            ds = (1/3)*(x2-x1);
        else 
            ds = 25;
        end
    end

    function ds = pos_iterate(x2, x1, dt)
        ds = speed_dep_dist(x1, x2)*dt;
    end

    function res = iterate(pos_vec, dt, fun_g)
        n = length(pos_vec);
        pos_vec(n) = pos_vec(n) + 5*dt;
        for j = 1:n-1
            x1_index = n-j;
            x2_index = n-j+1;
            x1_pos = pos_vec(x1_index);
            x2_pos = pos_vec(x2_index);
            
            pos_vec(x1_index) = pos_vec(x1_index) + pos_iterate(x2_pos, x1_pos, dt);
        end
        
        res = pos_vec;
    end

    position_vector = zeros(1, n_cars);
    for i = 1:length(position_vector)
        position_vector(i) = dist_cars*i;
        
    end
    
    euler_step = (t_interval(2)-t_interval(1))/n_steps;
    for k = 1:n_steps
       dt = euler_step;
       position_vector = iterate(position_vector, dt, fun_g);
       H(k,:) = position_vector
    end
    res = H
end


